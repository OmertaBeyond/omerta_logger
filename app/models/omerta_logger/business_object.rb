module OmertaLogger
  class BusinessObject < ActiveRecord::Base
    belongs_to :version
    belongs_to :user
    belongs_to :family
    has_many :business_object_owner_histories
    has_many :business_object_profit_histories
    has_many :business_object_protection_histories
    has_many :business_object_bankruptcy_histories

    enum object_type: [ :booze_warehouse, :bank, :construction_company,
                        :hospital, :narcotics_warehouse, :poker_basement, :travel_agency ]
    enum city: [ :detroit, :chicago, :new_york, :las_vegas,
                 :philadelphia, :baltimore, :corleone, :palermo ]

    before_save do |bo|
      save_owner_history if bo.user_id_changed? || bo.family_id_changed?
      save_profit_history if bo.profit_changed?
      save_protection_history if bo.protection_changed?
      save_bankruptcy_history if bo.bankrupt_changed?
    end

    def save_owner_history
      business_object_owner_histories.create(user: user, family: family, date: version.last_version_update.generated)
    end

    def save_profit_history
      business_object_profit_histories.create(profit: profit, date: version.last_version_update.generated)
    end

    def save_protection_history
      business_object_protection_histories.create(protection: protection, date: version.last_version_update.generated)
    end

    def save_bankruptcy_history
      business_object_bankruptcy_histories.create(bankrupt: bankrupt, date: version.last_version_update.generated)
    end
  end
end
