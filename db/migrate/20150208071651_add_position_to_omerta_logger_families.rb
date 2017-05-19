class AddPositionToOmertaLoggerFamilies < ActiveRecord::Migration[4.2]
  def change
    add_column :omerta_logger_families, :position, :integer
  end
end
