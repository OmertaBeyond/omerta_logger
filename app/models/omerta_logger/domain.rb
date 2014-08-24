module OmertaLogger
  class Domain < ActiveRecord::Base
    has_many :versions
  end
end
