desc "Import from XML API"
task :import, [ :domain, :users, :families ] => [ :environment ] do |t, args|
  args.with_defaults( :domain => "com",
                      :users => true,
                      :families => true,
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
end