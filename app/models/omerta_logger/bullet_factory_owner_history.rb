# == Schema Information
#
# Table name: omerta_logger_bullet_factory_owner_histories
#
#  id                :integer          not null, primary key
#  bullet_factory_id :integer
#  date              :datetime
#  user_id           :integer
#  family_id         :integer
#

module OmertaLogger
  class BulletFactoryOwnerHistory < ActiveRecord::Base
    belongs_to :user
    belongs_to :family
    belongs_to :bullet_factory
  end
end
