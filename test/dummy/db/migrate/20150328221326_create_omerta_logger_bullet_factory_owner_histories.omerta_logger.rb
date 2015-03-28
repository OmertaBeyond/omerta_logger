# This migration comes from omerta_logger (originally 20150328205945)
class CreateOmertaLoggerBulletFactoryOwnerHistories < ActiveRecord::Migration
  def change
    create_table :omerta_logger_bullet_factory_owner_histories do |t|
      t.references :bullet_factory
      t.datetime :date
      t.references :user
      t.references :family
      t.index :bullet_factory_id, name: 'index_owner_bullet_factory_id'
    end
  end
end
