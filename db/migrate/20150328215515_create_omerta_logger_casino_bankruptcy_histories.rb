class CreateOmertaLoggerCasinoBankruptcyHistories < ActiveRecord::Migration[4.2]
  def change
    create_table :omerta_logger_casino_bankruptcy_histories do |t|
      t.references :casino
      t.datetime :date
      t.boolean :bankrupt
      t.index :casino_id, name: 'index_bankruptcy_casino_id'
    end
  end
end
