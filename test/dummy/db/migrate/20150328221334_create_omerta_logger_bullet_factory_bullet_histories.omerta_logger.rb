# This migration comes from omerta_logger (originally 20150328220653)
class CreateOmertaLoggerBulletFactoryBulletHistories < ActiveRecord::Migration
  def change
    create_table :omerta_logger_bullet_factory_bullet_histories do |t|
      t.references :bullet_factory
      t.datetime :date
      t.integer :bullets, :limit => 3
      t.index :bullet_factory_id, name: 'index_bullet_bullet_factory_id'
    end
  end
end
