module OmertaLogger
  class CasinoOwnerHistory < ActiveRecord::Base
    belongs_to :user
    belongs_to :family
    belongs_to :casino
  end
end
