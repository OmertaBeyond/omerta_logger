# This migration comes from omerta_logger (originally 1408890044)
class CreateOmertaLoggerUsers < ActiveRecord::Migration
  def change
    create_table :omerta_logger_users do |t|
      t.integer :ext_user_id
      t.references :version, index: true
      t.string :name
      t.integer :gender
      t.integer :rank
      t.integer :honor_points
      t.integer :level
      t.boolean :donor
      t.datetime :first_seen
      t.datetime :last_seen
      t.references :family, index: true
      t.integer :family_role
      t.boolean :alive
      t.boolean :akill
      t.datetime :death_date
      t.string :death_family
      t.boolean :died_without_family
      t.integer :rip_topic

      t.timestamps
    end
  end
end
