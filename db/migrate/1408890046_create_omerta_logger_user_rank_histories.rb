class CreateOmertaLoggerUserRankHistories < ActiveRecord::Migration
  def change
    create_table :omerta_logger_user_rank_histories do |t|
      t.datetime :date
      t.integer :rank
      t.references :user, index: true
    end
  end
end
