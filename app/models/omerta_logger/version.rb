module OmertaLogger
  class Version < ActiveRecord::Base
    has_many :users
    has_many :families
    has_many :version_updates
    has_many :game_statistics
    belongs_to :domain

    def self.current
      self.where("start <= ? AND (end >= ? OR end IS NULL)", Time.now, Time.now).first!
    end

    # @return [OmertaLogger::VersionUpdate]
    def last_version_update
      version_updates.order("generated DESC").first
    end
  end
end
