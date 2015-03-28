# This migration comes from omerta_logger (originally 20150328205928)
class CreateOmertaLoggerBusinessObjectOwnerHistories < ActiveRecord::Migration
  def change
    create_table :omerta_logger_business_object_owner_histories do |t|
      t.references :business_object
      t.datetime :date
      t.references :user
      t.references :family
      t.index :business_object_id, name: 'index_owner_business_object_id'
    end
  end
end
