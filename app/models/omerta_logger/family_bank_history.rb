# == Schema Information
#
# Table name: omerta_logger_family_bank_histories
#
#  id        :integer          not null, primary key
#  date      :datetime
#  bank      :integer
#  family_id :integer
#

module OmertaLogger
  class FamilyBankHistory < ActiveRecord::Base
    belongs_to :family
  end
end
