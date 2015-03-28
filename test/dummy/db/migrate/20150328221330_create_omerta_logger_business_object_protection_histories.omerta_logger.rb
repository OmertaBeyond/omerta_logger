# This migration comes from omerta_logger (originally 20150328214026)
class CreateOmertaLoggerBusinessObjectProtectionHistories < ActiveRecord::Migration
  def change
    create_table :omerta_logger_business_object_protection_histories do |t|
      t.references :business_object
      t.datetime :date
      t.integer :protection, :limit => 1
      t.index :business_object_id, name: 'index_protection_business_object_id'
    end
  end
end
