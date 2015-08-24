require 'nokogiri'
require 'open-uri'
require 'omerta_logger/import/base'
require 'omerta_logger/import/family'
require 'omerta_logger/import/user'
require 'omerta_logger/import/game_statistic'
require 'omerta_logger/import/hitlist'
require 'omerta_logger/import/business'
require 'omerta_logger/import/archive_loader'
require 'time_difference'

module OmertaLogger
  module Import
    class Loader
      attr_accessor :domain, :xml, :generated, :version, :version_update, :previous_version_update

      def initialize(domain)
        @domain = Domain.find_by_name!(domain)
      end

      def end_previous_versions
        @domain.versions.where(end: nil).each do |v|
          last_version_update = v.last_version_update
          if last_version_update.nil?
            v.end = DateTime.zone.now
          else
            v.end = last_version_update.generated
          end
          v.save
          Rails.logger.info "ending version #{v.version} at #{v.end}"
        end
      end

      def find_or_create_version
        xml_version = @xml.at_css('version')
        begin
          @version = @domain.versions.find_by!(version: xml_version.text)
          Rails.logger.debug "loaded version #{@version.version}"
          if @generated < @version.start
            Rails.logger.info "updating version start to #{@generated}"
            @version.start = @generated
            @version.save
          end
        rescue ActiveRecord::RecordNotFound
          end_previous_versions
          @version = @domain.versions.create(version: xml_version.text, start: @generated)
          Rails.logger.info "created new version #{xml_version.text} on #{@domain.name}"
        end
      end

      def save_version_update(import_start)
        @version_update.duration = TimeDifference.between(import_start, Time.zone.now).in_seconds
        @version_update.save
        Rails.logger.info "imported update for #{@version.domain.name} in #{@version_update.duration}s"
      end

      def exec_import
        import_start = Time.zone.now
        Rails.logger.debug 'executing import'
        Family.new(self).import if OmertaLogger.config.family

        User.new(self).import if OmertaLogger.config.user

        GameStatistic.new(self).import if OmertaLogger.config.game_statistic

        Hitlist.new(self).import if OmertaLogger.config.hitlist

        Business.new(self).import

        save_version_update(import_start)
      end

      def import_from_api
        @xml = Nokogiri::XML(open(@domain.api_url)) do |config|
          config.strict.nonet
        end
        Rails.logger.debug "loaded XML from #{@domain.api_url}"
        import
      end

      def import_from_string(xml)
        @xml = Nokogiri::XML(xml) do |config|
          config.strict.nonet
        end
        import(true)
      end

      def scan_archive
        return false if !OmertaLogger.config.archive || (!@previous_version_update.nil? &&
            TimeDifference.between(@previous_version_update.generated, @generated).in_minutes <= 8)
        Rails.logger.info 'scanning archive for missed updates'
        archive_loader = OmertaLogger::Import::ArchiveLoader.new(@version)
        archive_loader.import
        return false unless archive_loader.imported_updates > 0
        # we found some updates in the archive. let's repeat everything to check if any new updates
        # have been pushed and/or archived in the meantime
        Rails.logger.info "#{archive_loader.imported_updates} were imported from archive"
        import_from_api
        true
      end

      # rubocop:disable Metrics/CyclomaticComplexity
      def import(skip_archive = false)
        @generated = Time.zone.at(@xml.at_css('generated').text.to_i)
        find_or_create_version

        @previous_version_update = @version.last_version_update
        return if !@previous_version_update.nil? && @previous_version_update.generated == @generated unless Rails.env.development?

        # check archive for possible missed updates
        return if !skip_archive && scan_archive

        @version_update = @version.version_updates.create(generated: @generated)
        @previous_version_update = @version_update if @previous_version_update.nil?

        exec_import
      end
    end
  end
end
