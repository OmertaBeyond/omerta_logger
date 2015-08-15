require 'nokogiri'
require 'open-uri'
require 'omerta_logger/import/base'
require 'omerta_logger/import/family'
require 'omerta_logger/import/user'
require 'omerta_logger/import/game_statistic'
require 'omerta_logger/import/hitlist'
require 'omerta_logger/import/business'
require 'time_difference'

module OmertaLogger
  module Import
    class Loader
      attr_accessor :domain, :xml, :generated, :version, :version_update, :previous_version_update

      def initialize(domain)
        @domain = domain
      end

      def load_xml(url)
        @xml = Nokogiri::XML(open(url)) do |config|
          config.strict.nonet
        end
        Rails.logger.debug "loaded XML from #{url}"
      end

      def find_or_create_version(domain)
        xml_version = @xml.at_css('version')
        begin
          @version = domain.versions.find_by!(version: xml_version.text)
          Rails.logger.debug "loaded version #{@version.version}"
        rescue ActiveRecord::RecordNotFound
          domain.versions.where(end: nil).each do |v|
            last_version_update = v.last_version_update
            if last_version_update.nil?
              v.end = DateTime.zone.now
            else
              v.end = last_version_update.generated
            end
            v.save
            Rails.logger.info "ending version #{v.version} at #{v.end}"
          end
          @version = domain.versions.create(version: xml_version.text, start: @generated)
          Rails.logger.info "created new version #{xml_version.text} on #{domain.name}"
        end
      end

      def save_version_update(import_start)
        @version_update.duration = TimeDifference.between(import_start, Time.zone.now).in_seconds
        @version_update.save
        Rails.logger.info "imported update for #{@version.domain.name} in #{@version_update.duration}s"
      end

      def exec_import
        Rails.logger.debug 'executing import'
        Family.new(self).import if OmertaLogger.config.family

        User.new(self).import if OmertaLogger.config.user

        GameStatistic.new(self).import if OmertaLogger.config.game_statistic

        Hitlist.new(self).import if OmertaLogger.config.hitlist

        Business.new(self).import
      end

      def import
        import_start = Time.zone.now
        domain = Domain.find_by_name!(@domain)
        load_xml(domain.api_url)
        @generated = Time.zone.at(@xml.at_css('generated').text.to_i)
        find_or_create_version(domain)

        @previous_version_update = @version.last_version_update
        return if !@previous_version_update.nil? && @previous_version_update.generated == @generated unless Rails.env.development?
        @version_update = @version.version_updates.create(generated: @generated)
        @previous_version_update = @version_update if @previous_version_update.nil?

        exec_import

        save_version_update(import_start)
      end
    end
  end
end
