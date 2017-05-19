class CreateOmertaLoggerBulletFactories < ActiveRecord::Migration[4.2]
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
