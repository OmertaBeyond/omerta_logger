module OmertaLogger
  class BusinessObjectOwnerHistory < ActiveRecord::Base
    belongs_to :user
    belongs_to :family
    belongs_to :business_object
  end
end
