require "time_difference"

module OmertaLogger
  class User < ActiveRecord::Base
    include ActiveModel::Dirty

    before_save do |u|
      self.save_rank_history if u.rank_changed?
      self.save_family_history if u.family_id_changed? || u.family_role_changed?
    end

    has_many :user_rank_histories
    has_many :user_family_histories
    has_many :user_online_times
    belongs_to :family
    belongs_to :version
    enum gender: [ :male, :female ]
    enum rank: [ :empty_suit, :delivery_boy, :delivery_girl, :picciotto, :shoplifter,
                 :pickpocket, :thief, :associate, :mobster, :soldier, :swindler,
                 :assassin, :local_chief, :chief, :bruglione, :capodecina,
                 :godfather, :first_lady ]
    enum level: [ :player, :translation_crew, :user_group ]
    enum family_role: [ :member, :capo, :sotto, :consig, :don ]

    def save_rank_history
      self.user_rank_histories.create({ rank: self.rank, date: self.last_seen })
    end

    def save_family_history
      self.user_family_histories.create({ family: self.family, family_role: self.family_role,
                                          date: self.last_seen })
    end

    def online_percentage
      return nil if first_seen.nil?
      version_time = TimeDifference.between(first_seen, death_date || version.last_version_update.generated || Time.now)
      (online_time_seconds / version_time.in_seconds) * 100
    end

    # @return [OmertaLogger::UserOnlineTime]
    def last_user_online_time
      user_online_times.order("end DESC").first
    end
  end
end
