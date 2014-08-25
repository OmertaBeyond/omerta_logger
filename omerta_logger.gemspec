$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "omerta_logger/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "omerta_logger"
  s.version     = OmertaLogger::VERSION
  s.authors     = ["MurderInc"]
  s.email       = ["MurderInc@faffie.biz"]
  s.homepage    = "https://github.com/Baelor/omerta_logger"
  s.summary     = "Provides a configurable logger for the MMORPG Omerta as a mountable rails engine."
  s.description = "Provides a configurable logger for the MMORPG Omerta as a mountable rails engine."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.5"
  s.add_dependency "nokogiri", "~> 1.6.3.1"
  s.add_dependency "rabl", "~> 0.11.0"

  s.add_development_dependency "sqlite3"
end
