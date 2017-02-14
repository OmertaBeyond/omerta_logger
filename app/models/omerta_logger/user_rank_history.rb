# == Schema Information
#
# Table name: omerta_logger_user_rank_histories
#
#  id      :integer          not null, primary key
#  date    :datetime
#  rank    :integer
#  user_id :integer
#

module OmertaLogger
  class UserRankHistory < ApplicationRecord
    belongs_to :user
    enum rank: [ :empty_suit, :delivery_boy, :delivery_girl, :picciotto, :shoplifter,
                 :pickpocket, :thief, :associate, :mobster, :soldier, :swindler,
                 :assassin, :local_chief, :chief, :bruglione, :capodecina,
                 :godfather, :first_lady ]
  end
end
