module OmertaLogger
  module Import
    class Base
      attr_accessor :loader, :xml, :version, :version_update, :previous_version_update
      def initialize(loader)
        @loader = loader
        @xml = @loader.xml
        @version = @loader.version
        @version_update = @loader.version_update
        @previous_version_update = @loader.previous_version_update
      end

      def enumify(string)
        string.parameterize.underscore.to_sym
      end
    end
  end
end
