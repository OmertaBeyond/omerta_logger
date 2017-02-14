# == Schema Information
#
# Table name: omerta_logger_bullet_factory_bullet_histories
#
#  id                :integer          not null, primary key
#  bullet_factory_id :integer
#  date              :datetime
#  bullets           :integer
#

module OmertaLogger
  class BulletFactoryBulletHistory < ApplicationRecord
    belongs_to :bullet_factory
  end
end
