class CreateOmertaLoggerBusinessObjectBankruptcyHistories < ActiveRecord::Migration[4.2]
  def change
    create_table :omerta_logger_business_object_bankruptcy_histories do |t|
      t.references :business_object
      t.datetime :date
      t.boolean :bankrupt
      t.index :business_object_id, name: 'index_bankruptcy_business_object_id'
    end
  end
end
