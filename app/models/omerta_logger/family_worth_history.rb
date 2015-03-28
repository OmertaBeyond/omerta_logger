# == Schema Information
#
# Table name: omerta_logger_family_worth_histories
#
#  id        :integer          not null, primary key
#  date      :datetime
#  worth     :integer
#  family_id :integer
#

module OmertaLogger
  class FamilyWorthHistory < ActiveRecord::Base
    belongs_to :family
  end
end
