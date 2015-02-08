module OmertaLogger
  class FamilyPositionHistory < ActiveRecord::Base
    belongs_to :family
  end
end
