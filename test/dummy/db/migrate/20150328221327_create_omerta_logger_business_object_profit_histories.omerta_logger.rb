# This migration comes from omerta_logger (originally 20150328212943)
class CreateOmertaLoggerBusinessObjectProfitHistories < ActiveRecord::Migration
  def change
    create_table :omerta_logger_business_object_profit_histories do |t|
      t.references :business_object
      t.datetime :date
      t.integer :profit
      t.index :business_object_id, name: 'index_profit_business_object_id'
    end
  end
end
