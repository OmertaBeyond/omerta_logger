# This migration comes from omerta_logger (originally 20150208072820)
class CreateOmertaLoggerFamilyPositionHistories < ActiveRecord::Migration
  def change
    create_table :omerta_logger_family_position_histories do |t|
      t.datetime :date
      t.integer :position
      t.references :family, index: true
    end
  end
end
