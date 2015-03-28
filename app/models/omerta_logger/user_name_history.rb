# == Schema Information
#
# Table name: omerta_logger_user_name_histories
#
#  id      :integer          not null, primary key
#  name    :string
#  date    :datetime
#  user_id :integer
#

module OmertaLogger
  class UserNameHistory < ActiveRecord::Base
    belongs_to :user
  end
end
