# This migration comes from omerta_logger (originally 20150208071651)
class AddPositionToOmertaLoggerFamilies < ActiveRecord::Migration[4.2]
  def change
    add_column :omerta_logger_families, :position, :integer
  end
end
