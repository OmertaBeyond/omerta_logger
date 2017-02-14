# == Schema Information
#
# Table name: omerta_logger_casino_profit_histories
#
#  id        :integer          not null, primary key
#  casino_id :integer
#  date      :datetime
#  profit    :integer
#

module OmertaLogger
  class CasinoProfitHistory < ApplicationRecord
    belongs_to :casino
  end
end
