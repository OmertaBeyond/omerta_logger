desc "Import from XML API"
task :import, [ :daemonize ] => [ :environment ] do |t, args|
  if !OmertaLogger.config.respond_to? :domains
    raise "Please provide initializer file. See test/dummy/config/initializers/omerta_logger.rb.example"
  end

  args.with_defaults( :daemonize => false )
  require "#{OmertaLogger::Engine.root}/lib/omerta_logger/import/loader"
  begin
    OmertaLogger.config.domains.each do |domain|
      loader = OmertaLogger::Import::Loader.new(domain)
      loader.import
    end
    sleep 65 - Time.zone.now.sec if args.daemonize # sleep until 5 seconds after the next minute starts
  end while args.daemonize
end
