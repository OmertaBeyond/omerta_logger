module OmertaLogger
  class BusinessObjectProfitHistory < ActiveRecord::Base
    belongs_to :business_object
  end
end
