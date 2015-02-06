module OmertaLogger
  class FamilyBankHistory < ActiveRecord::Base
    belongs_to :family
  end
end
