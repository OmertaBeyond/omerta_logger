# This migration comes from omerta_logger (originally 1408890043)
class CreateOmertaLoggerFamilies < ActiveRecord::Migration
  def change
    create_table :omerta_logger_families do |t|
      t.integer :ext_family_id
      t.references :version, index: true
      t.string :name
      t.integer :worth
      t.integer :rank
      t.integer :user_count
      t.integer :hq
      t.string :color
      t.integer :bank
      t.integer :city
      t.integer :don_id
      t.integer :sotto_id
      t.integer :consig_id
      t.datetime :first_seen
      t.boolean :alive
      t.datetime :death_date
      t.integer :rip_topic

      t.timestamps
    end
  end
end
