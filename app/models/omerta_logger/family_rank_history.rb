# == Schema Information
#
# Table name: omerta_logger_family_rank_histories
#
#  id        :integer          not null, primary key
#  date      :datetime
#  rank      :integer
#  family_id :integer
#

module OmertaLogger
  class FamilyRankHistory < ApplicationRecord
    belongs_to :family
  end
end
