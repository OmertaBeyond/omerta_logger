# == Schema Information
#
# Table name: omerta_logger_casino_owner_histories
#
#  id        :integer          not null, primary key
#  casino_id :integer
#  date      :datetime
#  user_id   :integer
#  family_id :integer
#

module OmertaLogger
  class CasinoOwnerHistory < ActiveRecord::Base
    belongs_to :user
    belongs_to :family
    belongs_to :casino
  end
end
