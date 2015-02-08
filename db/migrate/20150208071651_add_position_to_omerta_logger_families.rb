class AddPositionToOmertaLoggerFamilies < ActiveRecord::Migration
  def change
    add_column :omerta_logger_families, :position, :integer
  end
end
