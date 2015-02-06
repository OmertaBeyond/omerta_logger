module OmertaLogger
  class Family < ActiveRecord::Base
    has_many :users
    has_many :user_family_histories
    has_many :family_name_histories
    has_many :family_rank_histories
    belongs_to :don, class_name: User
    belongs_to :sotto, class_name: User
    belongs_to :consig, class_name: User
    belongs_to :version

    enum city: [ :detroit, :chicago, :new_york, :las_vegas,
                 :philadelphia, :baltimore, :corleone, :palermo ]

    before_save do |f|
      save_name_history if !f.new_record? && f.name_changed? && !f.name_was.nil?
      save_rank_history if f.rank_changed?
    end

    def save_name_history
      family_name_histories.create(name: name_was, date: version.last_version_update.generated)
    end

    def save_rank_history
      family_rank_histories.create(rank: rank, date: version.last_version_update.generated)
    end
  end
end
