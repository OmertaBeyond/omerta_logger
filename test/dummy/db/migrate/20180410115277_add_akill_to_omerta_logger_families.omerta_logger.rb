# This migration comes from omerta_logger (originally 20160121182421)
class AddAkillToOmertaLoggerFamilies < ActiveRecord::Migration[4.2]
  def change
    add_column :omerta_logger_families, :akill, :boolean
  end
end
