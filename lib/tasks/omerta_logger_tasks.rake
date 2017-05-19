desc 'Import from XML API'
task :import, [ :daemonize ] => [ :environment ] do |_t, args|
  unless OmertaLogger.config.respond_to? :domains
    raise 'Please provide initializer file. See test/dummy/config/initializers/omerta_logger.rb.example'
  end

  args.with_defaults(daemonize: false)
  require "#{OmertaLogger::Engine.root}/lib/omerta_logger/import/loader"
  loop do
    OmertaLogger.config.domains.each do |domain|
      loader = OmertaLogger::Import::Loader.new(domain)
      loader.import_from_api
    end
    sleep 65 - Time.zone.now.sec if args.daemonize # sleep until 5 seconds after the next minute starts
    break unless args.daemonize
  end
end

namespace :version do
  desc 'delete a version'
  task :delete, %i[domain version] => [ :environment ] do |_t, args|
    unless args.to_hash.key?(:domain) && args.to_hash.key?(:version)
      raise 'Please provide the domain and version you would like to delete'
    end

    domain = OmertaLogger::Domain.find_by!(name: args[:domain])
    version = domain.versions.find_by!(version: args[:version])
    version.destroy
    puts "Deleted #{domain.name}v#{version.version}"
  end
end
