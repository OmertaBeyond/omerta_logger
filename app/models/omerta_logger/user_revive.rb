module OmertaLogger
  class UserRevive < ActiveRecord::Base
    belongs_to :user
  end
end
