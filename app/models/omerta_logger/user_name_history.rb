module OmertaLogger
  class UserNameHistory < ActiveRecord::Base
    belongs_to :user
  end
end
