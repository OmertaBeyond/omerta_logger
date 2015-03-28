module OmertaLogger
  class BulletFactoryBulletHistory < ActiveRecord::Base
    belongs_to :bullet_factory
  end
end
