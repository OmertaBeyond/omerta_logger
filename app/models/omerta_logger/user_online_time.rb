# == Schema Information
#
# Table name: omerta_logger_user_online_times
#
#  id      :integer          not null, primary key
#  user_id :integer
#  start   :datetime
#  end     :datetime
#

module OmertaLogger
  class UserOnlineTime < ApplicationRecord
    belongs_to :user
  end
end
