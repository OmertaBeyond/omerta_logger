# == Schema Information
#
# Table name: omerta_logger_families
#
#  id            :integer          not null, primary key
#  ext_family_id :integer
#  version_id    :integer
#  name          :string
#  worth         :integer
#  rank          :integer
#  user_count    :integer
#  hq            :integer
#  color         :string
#  bank          :integer
#  city          :integer
#  don_id        :integer
#  sotto_id      :integer
#  consig_id     :integer
#  first_seen    :datetime
#  alive         :boolean
#  death_date    :datetime
#  rip_topic     :integer
#  created_at    :datetime
#  updated_at    :datetime
#  position      :integer
#

module OmertaLogger
  class Family < ActiveRecord::Base
    has_many :users
    has_many :user_family_histories
    has_many :family_name_histories
    has_many :family_rank_histories
    has_many :family_worth_histories
    has_many :family_user_count_histories
    has_many :family_bank_histories
    has_many :family_position_histories
    has_many :casinos
    has_many :business_objects
    has_many :bullet_factories
    belongs_to :don, class_name: User
    belongs_to :sotto, class_name: User
    belongs_to :consig, class_name: User
    belongs_to :version

    enum city: [ :detroit, :chicago, :new_york, :las_vegas,
                 :philadelphia, :baltimore, :corleone, :palermo ]

    before_save do |f|
      save_name_history if !f.new_record? && f.name_changed? && !f.name_was.nil?
      save_rank_history if f.rank_changed?
      save_worth_history if f.worth_changed?
      save_user_count_history if f.user_count_changed?
      save_bank_history if f.bank_changed?
      save_position_history if f.position_changed?
    end

    after_save do |f|
      remove_users if f.alive_changed? && !f.alive && f.alive_was
    end

    def save_name_history
      family_name_histories.create(name: name_was, date: version.last_version_update.generated)
    end

    def save_rank_history
      family_rank_histories.create(rank: rank, date: version.last_version_update.generated)
    end

    def save_worth_history
      family_worth_histories.create(worth: worth, date: version.last_version_update.generated)
    end

    def save_user_count_history
      family_user_count_histories.create(user_count: user_count, date: version.last_version_update.generated)
    end

    def save_bank_history
      family_bank_histories.create(bank: bank, date: version.last_version_update.generated)
    end

    def save_position_history
      family_position_histories.create(position: position, date: version.last_version_update.generated)
    end

    def remove_users
      users.each do |u|
        u.family = nil
        u.family_role = nil
        u.save
      end
    end
  end
end
