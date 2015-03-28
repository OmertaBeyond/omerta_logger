# This migration comes from omerta_logger (originally 20150328213641)
class CreateOmertaLoggerCasinoMaxBetHistories < ActiveRecord::Migration
  def change
    create_table :omerta_logger_casino_max_bet_histories do |t|
      t.references :casino
      t.datetime :date
      t.integer :max_bet
      t.index :casino_id, name: 'index_max_bet_casino_id'
    end
  end
end
