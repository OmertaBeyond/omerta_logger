module OmertaLogger
  class CasinoBankruptcyHistory < ActiveRecord::Base
    belongs_to :casino
  end
end
