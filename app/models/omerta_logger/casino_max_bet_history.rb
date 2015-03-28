# == Schema Information
#
# Table name: omerta_logger_casino_max_bet_histories
#
#  id        :integer          not null, primary key
#  casino_id :integer
#  date      :datetime
#  max_bet   :integer
#

module OmertaLogger
  class CasinoMaxBetHistory < ActiveRecord::Base
    belongs_to :casino
  end
end
