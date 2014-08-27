require "nokogiri"
require "open-uri"
require "omerta_logger/import/base"
require "omerta_logger/import/family"
require "omerta_logger/import/user"

module OmertaLogger
  module Import
    class Loader
      attr_accessor :domain, :users, :families
      attr_accessor :version, :xml, :generated

      def initialize(flags = {})
        @domain = flags.values_at(:domain)
        @users = flags.values_at(:users)
        @families = flags.values_at(:families)
      end

      def import
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
          end
        end
        family_import = Family.new(self)
        if @families
          family_import.import_families
        end

        if @users
          user_import = User.new(self)
          user_import.import_users
        end

        if @families
          family_import.import_tops
        end
      end
    end
  end
end