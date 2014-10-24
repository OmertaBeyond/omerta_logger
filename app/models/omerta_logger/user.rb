require "time_difference"

module OmertaLogger
  class User < ActiveRecord::Base
    include ActiveModel::Dirty

    before_save do |u|
      self.save_rank_history if u.rank_changed?
      self.save_family_history if u.family_id_changed? || u.family_role_changed?
      if u.last_seen_changed? && !u.last_seen_was.nil?
        u.online_time_seconds += if TimeDifference.between(u.last_seen_was, u.last_seen).in_minutes < 10
                                   TimeDifference.between(u.last_seen_was, u.last_seen).in_seconds
                                 else
                                   #i_have_no_idea_what_i'm_doing.jpg
                                   5 * 60
                                 end

      end
    end

    has_many :user_rank_histories
    has_many :user_family_histories
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
      #TODO: use last logger sequence instead of Time.now
      (online_time_seconds / TimeDifference.between(death_date || first_seen, Time.now).in_seconds) * 100
    end
  end
end
