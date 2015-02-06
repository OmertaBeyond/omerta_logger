module OmertaLogger
  class FamilyRankHistory < ActiveRecord::Base
    belongs_to :family
  end
end
