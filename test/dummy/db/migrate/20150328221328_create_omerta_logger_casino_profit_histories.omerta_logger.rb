# This migration comes from omerta_logger (originally 20150328213014)
class CreateOmertaLoggerCasinoProfitHistories < ActiveRecord::Migration
  def change
    create_table :omerta_logger_casino_profit_histories do |t|
      t.references :casino
      t.datetime :date
      t.integer :profit
      t.index :casino_id, name: 'index_profit_casino_id'
    end
  end
end
