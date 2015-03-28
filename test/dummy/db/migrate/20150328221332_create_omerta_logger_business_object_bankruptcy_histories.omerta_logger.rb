# This migration comes from omerta_logger (originally 20150328215502)
class CreateOmertaLoggerBusinessObjectBankruptcyHistories < ActiveRecord::Migration
  def change
    create_table :omerta_logger_business_object_bankruptcy_histories do |t|
      t.references :business_object
      t.datetime :date
      t.boolean :bankrupt
      t.index :business_object_id, name: 'index_bankruptcy_business_object_id'
    end
  end
end
