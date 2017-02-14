# == Schema Information
#
# Table name: omerta_logger_user_revives
#
#  id      :integer          not null, primary key
#  date    :datetime
#  user_id :integer
#

module OmertaLogger
  class UserRevive < ApplicationRecord
    belongs_to :user
  end
end
