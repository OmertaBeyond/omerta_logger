module OmertaLogger
  class BulletFactoryOwnerHistory < ActiveRecord::Base
    belongs_to :user
    belongs_to :family
    belongs_to :bullet_factory
  end
end
