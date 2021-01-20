$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'omerta_logger/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'omerta_logger'
  s.version     = OmertaLogger::VERSION
  s.authors     = ['MurderInc']
  s.email       = ['MurderInc@omertabeyond.net']
  s.homepage    = 'https://github.com/Baelor/omerta_logger'
  s.summary     = 'Provides a configurable logger for the MMORPG Omerta as a mountable rails engine.'
  s.description = 'Provides a configurable logger for the MMORPG Omerta as a mountable rails engine.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'http', '>= 3', '< 5'
  s.add_dependency 'net-ftp-list', '~> 3.2'
  s.add_dependency 'nokogiri', '~> 1.10'
  s.add_dependency 'rabl', '~> 0.14'
  s.add_dependency 'rails', '~> 6.0'
  s.add_dependency 'sidekiq', '~> 6.0'
  s.add_dependency 'sidekiq-scheduler', '>= 3', '< 4.0'
  s.add_dependency 'sidekiq-unique-jobs', '>= 6', '< 8'
  s.add_dependency 'time_difference', '~> 0.5'
  s.add_dependency 'concurrent-ruby', '~> 1.1'

  s.add_development_dependency 'annotate', '~> 3.0', '>= 3.0.3'
  s.add_development_dependency 'bootsnap', '~> 1.4'
  s.add_development_dependency 'bullet', '~> 6.0'
  s.add_development_dependency 'listen', '~> 3.2'
  s.add_development_dependency 'sqlite3', '~> 1.4'
end
