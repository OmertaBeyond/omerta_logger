# == Schema Information
#
# Table name: omerta_logger_bullet_factory_price_histories
#
#  id                :integer          not null, primary key
#  bullet_factory_id :integer
#  date              :datetime
#  price             :integer
#

module OmertaLogger
  class BulletFactoryPriceHistory < ActiveRecord::Base
    belongs_to :bullet_factory
  end
end
