# == Schema Information
#
# Table name: omerta_logger_casino_protection_histories
#
#  id         :integer          not null, primary key
#  casino_id  :integer
#  date       :datetime
#  protection :integer
#

module OmertaLogger
  class CasinoProtectionHistory < ActiveRecord::Base
    belongs_to :casino
  end
end
