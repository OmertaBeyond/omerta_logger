module OmertaLogger
  class VersionUpdate < ActiveRecord::Base
    belongs_to :version
  end
end
