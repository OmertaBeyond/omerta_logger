# This migration comes from omerta_logger (originally 20150328202427)
class CreateOmertaLoggerBulletFactories < ActiveRecord::Migration
  def change
    create_table :omerta_logger_bullet_factories do |t|
      t.integer :ext_bullet_factory_id, :limit => 2
      t.references :version, index: true
      t.references :user, index: true
      t.references :family, index: true
      t.integer :city, :limit => 1
      t.integer :price, :limit => 2
      t.integer :bullets, :limit => 3
    end
  end
end
