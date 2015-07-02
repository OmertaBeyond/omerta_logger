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
    sleep 65 - Time.zone.now.sec if args.daemnoize # sleep until 5 seconds after the next minute starts
  end while args.daemonize
end

namespace :version do
  desc "create a new version"
  task :new, [ :version, :domain, :start_date ] => [ :environment ] do |t, args|
    args.with_defaults( :domain => "com",
                        :start_date => Time.now )
    start_date = args[:start_date]
    if !start_date.is_a? Time
      start_date = Time.parse(start_date)
    end
    domain = OmertaLogger::Domain.find_by_name!(args[:domain])
    domain.versions.create({ version:  args[:version], start: start_date })
  end

  desc "ends a version"
  task :end, [ :version, :domain, :end_date ] => [ :environment ] do |t, args|
    args.with_defaults( :domain => "com",
                        :end_date => Time.now )
    end_date = args[:end_date]
    if !end_date.is_a? Time
      end_date = Time.parse(end_date)
    end
    domain = OmertaLogger::Domain.find_by_name!(args[:domain])
    version = domain.versions.find_by_version!(args[:version])
    version.end = end_date
    version.save
  end
end