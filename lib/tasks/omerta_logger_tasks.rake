desc "Import from XML API"
task :import, [ :domain, :users, :families, :game_statistics, :hitlist ] => [ :environment ] do |t, args|
  args.with_defaults( :domain => "com",
                      :users => true,
                      :families => true,
                      :game_statistics => true,
                      :hitlist => true,
                      :user_rank_history => true,
                      :user_family_history => true )
  require "#{OmertaLogger::Engine.root}/lib/omerta_logger/import/loader"
  loader = OmertaLogger::Import::Loader.new(args)
  loader.import
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