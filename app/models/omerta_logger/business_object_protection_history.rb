module OmertaLogger
  class BusinessObjectProtectionHistory < ActiveRecord::Base
    belongs_to :business_object
  end
end
