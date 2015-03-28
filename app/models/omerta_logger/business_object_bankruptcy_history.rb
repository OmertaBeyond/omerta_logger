module OmertaLogger
  class BusinessObjectBankruptcyHistory < ActiveRecord::Base
    belongs_to :business_object
  end
end
