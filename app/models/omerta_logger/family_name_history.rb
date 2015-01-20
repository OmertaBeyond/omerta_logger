module OmertaLogger
  class FamilyNameHistory < ActiveRecord::Base
    belongs_to :family
  end
end
