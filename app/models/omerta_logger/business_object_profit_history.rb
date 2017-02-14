# == Schema Information
#
# Table name: omerta_logger_business_object_profit_histories
#
#  id                 :integer          not null, primary key
#  business_object_id :integer
#  date               :datetime
#  profit             :integer
#

module OmertaLogger
  class BusinessObjectProfitHistory < ApplicationRecord
    belongs_to :business_object
  end
end
