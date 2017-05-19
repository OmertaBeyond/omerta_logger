# == Schema Information
#
# Table name: omerta_logger_user_family_histories
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  family_id   :integer
#  date        :datetime
#  family_role :integer
#

module OmertaLogger
  class UserFamilyHistory < ApplicationRecord
    belongs_to :user
    belongs_to :family
    enum family_role: %i[member capo sotto consig don]
  end
end
