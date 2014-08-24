module OmertaLogger
  module Import
    class Base
      attr_accessor :loader, :xml, :version
      def initialize(loader)
        @loader = loader
        @xml = @loader.xml
        @version = @loader.version
      end
    end
  end
end