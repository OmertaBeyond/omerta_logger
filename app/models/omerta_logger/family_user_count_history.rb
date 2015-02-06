module OmertaLogger
  class FamilyUserCountHistory < ActiveRecord::Base
    belongs_to :family
  end
end
