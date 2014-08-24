module OmertaLogger
  class Version < ActiveRecord::Base
    has_many :users
    has_many :families
    belongs_to :domain

    def self.current
      self.where("start <= ? AND (end >= ? OR end IS NULL)", Time.now, Time.now).first!
    end
  end
end
