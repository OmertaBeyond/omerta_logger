module OmertaLogger
  class UserOnlineTime < ActiveRecord::Base
    belongs_to :user
  end
end
