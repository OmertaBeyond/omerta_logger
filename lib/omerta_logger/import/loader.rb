require "nokogiri"
require "open-uri"
require "omerta_logger/import/base"
require "omerta_logger/import/family"
require "omerta_logger/import/user"
require "omerta_logger/import/game_statistic"
require "time_difference"

module OmertaLogger
  module Import
    class Loader
      attr_accessor :domain, :users, :families, :game_statistics, :xml, :generated
      attr_accessor :version, :version_update, :previous_version_update

      def initialize(flags = {})
        @domain = flags.values_at(:domain)
        @users = flags.values_at(:users)
        @families = flags.values_at(:families)
        @game_statistics = flags.values_at(:game_statistics)
      end

      def import
        import_start = Time.now
        domain = Domain.find_by_name!(@domain)
        @xml = Nokogiri::XML(open(domain.api_url)) do |config|
          config.strict.nonet
        end
        @generated = Time.at(xml.css("generated").first.text.to_i)
        xml_version = xml.css("version").first
        if xml_version.nil?
          @version = domain.versions.current
        else
          begin
            @version = domain.versions.find_by!(version: xml_version.text)
          rescue ActiveRecord::RecordNotFound
            @version = domain.versions.create(version: xml_version.text, start: @generated)
            Rails.logger.info "created new version #{xml_version.text} on #{domain.name}"
          end
        end
        @previous_version_update = @version.last_version_update
        return if !@previous_version_update.nil? && @previous_version_update.generated == @generated unless Rails.env.development?
        @version_update = @version.version_updates.create(generated: @generated)
        @previous_version_update = @version_update if @previous_version_update.nil?
        family_import = Family.new(self)
        if @families
          family_import.import_families
          family_import.import_deaths
        end

        if @users
          user_import = User.new(self)
          user_import.import_users
          user_import.import_deaths
        end

        if @families
          family_import.import_tops
        end

        if @game_statistics
          game_statistic_import = GameStatistic.new(self)
          game_statistic_import.import
        end

        @version_update.duration = TimeDifference.between(import_start, Time.now).in_seconds
        @version_update.save
        Rails.logger.info "imported update for #{domain.name} in #{@version_update.duration}s"
      end
    end
  end
end