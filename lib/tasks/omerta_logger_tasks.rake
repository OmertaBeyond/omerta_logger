namespace :version do
  desc 'delete a version'
  task :delete, %i[domain version] => [:environment] do |_t, args|
    unless args.to_hash.key?(:domain) && args.to_hash.key?(:version)
      raise 'Please provide the domain and version you would like to delete'
    end

    domain = OmertaLogger::Domain.find_by!(name: args[:domain])
    version = domain.versions.find_by!(version: args[:version])
    version.destroy
    puts "Deleted #{domain.name}v#{version.version}"
  end
end
