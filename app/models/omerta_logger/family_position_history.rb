# == Schema Information
#
# Table name: omerta_logger_family_position_histories
#
#  id        :integer          not null, primary key
#  date      :datetime
#  position  :integer
#  family_id :integer
#

module OmertaLogger
  class FamilyPositionHistory < ActiveRecord::Base
    belongs_to :family
  end
end
