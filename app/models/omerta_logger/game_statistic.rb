# == Schema Information
#
# Table name: omerta_logger_game_statistics
#
#  id                  :integer          not null, primary key
#  date                :datetime
#  version_id          :integer
#  users_total         :integer
#  users_alive         :integer
#  users_dead          :integer
#  lackeys_working     :integer
#  users_online_now    :integer
#  users_online_today  :integer
#  users_online_week   :integer
#  registrations_today :integer
#  registrations_week  :integer
#  bullets             :integer
#  money_pocket        :integer
#  money_bank          :integer
#  money_familybank    :integer
#  honorpoints         :integer
#  car_attempts        :integer
#  crime_attempts      :integer
#  bustouts            :integer
#  cars                :integer
#

module OmertaLogger
  class GameStatistic < ApplicationRecord
    belongs_to :version
  end
end
