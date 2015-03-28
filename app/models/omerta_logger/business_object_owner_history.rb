# == Schema Information
#
# Table name: omerta_logger_business_object_owner_histories
#
#  id                 :integer          not null, primary key
#  business_object_id :integer
#  date               :datetime
#  user_id            :integer
#  family_id          :integer
#

module OmertaLogger
  class BusinessObjectOwnerHistory < ActiveRecord::Base
    belongs_to :user
    belongs_to :family
    belongs_to :business_object
  end
end
