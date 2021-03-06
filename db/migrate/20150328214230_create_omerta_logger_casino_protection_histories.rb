class CreateOmertaLoggerCasinoProtectionHistories < ActiveRecord::Migration[4.2]
  def change
    create_table :omerta_logger_casino_protection_histories do |t|
      t.references :casino
      t.datetime :date
      t.integer :protection, :limit => 1
      t.index :casino_id, name: 'index_protection_casino_id'
    end
  end
end
