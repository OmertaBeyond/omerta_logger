# == Schema Information
#
# Table name: omerta_logger_versions
#
#  id         :integer          not null, primary key
#  version    :string
#  domain_id  :integer
#  start      :datetime
#  end        :datetime
#  created_at :datetime
#  updated_at :datetime
#

module OmertaLogger
  class Version < ActiveRecord::Base
    has_many :users
    has_many :families
    has_many :version_updates
    has_many :game_statistics
    has_many :hitlists
    has_many :casinos
    has_many :business_objects
    has_many :bullet_factories
    belongs_to :domain

    def self.current
      where('start <= ? AND (end >= ? OR end IS NULL)', Time.zone.now, Time.zone.now).first!
    end

    # @return [OmertaLogger::VersionUpdate]
    def last_version_update
      version_updates.order('generated DESC').first
    end
  end
end
