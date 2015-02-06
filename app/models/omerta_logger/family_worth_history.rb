module OmertaLogger
  class FamilyWorthHistory < ActiveRecord::Base
    belongs_to :family
  end
end
