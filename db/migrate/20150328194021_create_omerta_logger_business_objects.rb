class CreateOmertaLoggerBusinessObjects < ActiveRecord::Migration[4.2]
  def change
    create_table :omerta_logger_business_objects do |t|
      t.integer :ext_object_id, :limit => 2
      t.references :version, index: true
      t.references :user, index: true
      t.references :family, index: true
      t.integer :object_type, :limit => 1
      t.integer :city, :limit => 1
      t.integer :profit
      t.integer :protection, :limit => 1
      t.boolean :bankrupt
    end
  end
end
