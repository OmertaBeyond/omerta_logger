# == Schema Information
#
# Table name: omerta_logger_business_object_bankruptcy_histories
#
#  id                 :integer          not null, primary key
#  business_object_id :integer
#  date               :datetime
#  bankrupt           :boolean
#

module OmertaLogger
  class BusinessObjectBankruptcyHistory < ApplicationRecord
    belongs_to :business_object
  end
end
