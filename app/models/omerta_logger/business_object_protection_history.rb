# == Schema Information
#
# Table name: omerta_logger_business_object_protection_histories
#
#  id                 :integer          not null, primary key
#  business_object_id :integer
#  date               :datetime
#  protection         :integer
#

module OmertaLogger
  class BusinessObjectProtectionHistory < ApplicationRecord
    belongs_to :business_object
  end
end
