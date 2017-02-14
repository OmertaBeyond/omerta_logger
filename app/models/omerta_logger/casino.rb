# == Schema Information
#
# Table name: omerta_logger_casinos
#
#  id            :integer          not null, primary key
#  ext_casino_id :integer
#  version_id    :integer
#  user_id       :integer
#  family_id     :integer
#  casino_type   :integer
#  city          :integer
#  profit        :integer
#  max_bet       :integer
#  protection    :integer
#  bankrupt      :boolean
#

module OmertaLogger
  class Casino < ApplicationRecord
    belongs_to :version
    belongs_to :user
    belongs_to :family
    has_many :casino_owner_histories, dependent: :destroy
    has_many :casino_profit_histories, dependent: :destroy
    has_many :casino_max_bet_histories, dependent: :destroy
    has_many :casino_protection_histories, dependent: :destroy
    has_many :casino_bankruptcy_histories, dependent: :destroy

    enum casino_type: [ :blackjack, :numbers_game, :punto_banco,
                        :roulette, :slotmachine ]
    enum city: [ :detroit, :chicago, :new_york, :las_vegas,
                 :philadelphia, :baltimore, :corleone, :palermo ]

    before_save do |c|
      save_owner_history if OmertaLogger.config.casino_owner_history && (
        c.user_id_changed? || c.family_id_changed?
      )
      save_profit_history if OmertaLogger.config.casino_profit_history && c.profit_changed?
      save_max_bet_history if OmertaLogger.config.casino_max_bet_history && c.max_bet_changed?
      save_protection_history if OmertaLogger.config.casino_protection_history && c.protection_changed?
      save_bankruptcy_history if OmertaLogger.config.casino_bankruptcy_history && c.bankrupt_changed?
    end

    def save_owner_history
      casino_owner_histories.create(user: user, family: family, date: version.last_version_update.generated)
    end

    def save_profit_history
      casino_profit_histories.create(profit: profit, date: version.last_version_update.generated)
    end

    def save_max_bet_history
      casino_max_bet_histories.create(max_bet: max_bet, date: version.last_version_update.generated)
    end

    def save_protection_history
      casino_protection_histories.create(protection: protection, date: version.last_version_update.generated)
    end

    def save_bankruptcy_history
      casino_bankruptcy_histories.create(bankrupt: bankrupt, date: version.last_version_update.generated)
    end
  end
end
