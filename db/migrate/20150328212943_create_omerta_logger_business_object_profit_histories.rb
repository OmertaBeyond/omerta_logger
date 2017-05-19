class CreateOmertaLoggerBusinessObjectProfitHistories < ActiveRecord::Migration[4.2]
  def change
    create_table :omerta_logger_business_object_profit_histories do |t|
      t.references :business_object
      t.datetime :date
      t.integer :profit
      t.index :business_object_id, name: 'index_profit_business_object_id'
    end
  end
end
