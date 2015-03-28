# This migration comes from omerta_logger (originally 20150328214230)
class CreateOmertaLoggerCasinoProtectionHistories < ActiveRecord::Migration
  def change
    create_table :omerta_logger_casino_protection_histories do |t|
      t.references :casino
      t.datetime :date
      t.integer :protection, :limit => 1
      t.index :casino_id, name: 'index_protection_casino_id'
    end
  end
end
