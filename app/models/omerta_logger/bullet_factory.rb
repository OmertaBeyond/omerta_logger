# == Schema Information
#
# Table name: omerta_logger_bullet_factories
#
#  id                    :integer          not null, primary key
#  ext_bullet_factory_id :integer
#  version_id            :integer
#  user_id               :integer
#  family_id             :integer
#  city                  :integer
#  price                 :integer
#  bullets               :integer
#

module OmertaLogger
  class BulletFactory < ActiveRecord::Base
    belongs_to :version
    belongs_to :user
    belongs_to :family
    has_many :bullet_factory_owner_histories
    has_many :bullet_factory_bullet_histories
    has_many :bullet_factory_price_histories

    enum city: [ :detroit, :chicago, :new_york, :las_vegas,
                 :philadelphia, :baltimore, :corleone, :palermo ]

    before_save do |bf|
      save_owner_history if bf.user_id_changed? || bf.family_id_changed?
      save_bullet_history if bf.bullets_changed?
      save_price_history if bf.price_changed?
    end

    def save_owner_history
      bullet_factory_owner_histories.create(user: user, family: family, date: version.last_version_update.generated)
    end

    def save_bullet_history
      bullet_factory_bullet_histories.create(bullets: bullets, date: version.last_version_update.generated)
    end

    def save_price_history
      bullet_factory_price_histories.create(price: price, date: version.last_version_update.generated)
    end
  end
end
