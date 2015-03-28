# == Schema Information
#
# Table name: omerta_logger_family_user_count_histories
#
#  id         :integer          not null, primary key
#  date       :datetime
#  user_count :integer
#  family_id  :integer
#

module OmertaLogger
  class FamilyUserCountHistory < ActiveRecord::Base
    belongs_to :family
  end
end
