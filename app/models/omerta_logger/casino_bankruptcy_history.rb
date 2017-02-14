# == Schema Information
#
# Table name: omerta_logger_casino_bankruptcy_histories
#
#  id        :integer          not null, primary key
#  casino_id :integer
#  date      :datetime
#  bankrupt  :boolean
#

module OmertaLogger
  class CasinoBankruptcyHistory < ApplicationRecord
    belongs_to :casino
  end
end
