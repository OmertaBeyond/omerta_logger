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
  class Version < ApplicationRecord
    has_many :users, dependent: :destroy
    has_many :families, dependent: :destroy
    has_many :version_updates, dependent: :destroy
    has_many :game_statistics, dependent: :destroy
    has_many :hitlists, dependent: :destroy
    has_many :casinos, dependent: :destroy
    has_many :business_objects, dependent: :destroy
    has_many :bullet_factories, dependent: :destroy
    belongs_to :domain

    def self.current
      where('"start" <= ? AND ("end" >= ? OR "end" IS NULL)', Time.zone.now, Time.zone.now).first!
    end

    # @return [OmertaLogger::VersionUpdate]
    def last_version_update
      version_updates.order(generated: :desc).first
    end
  end
end
