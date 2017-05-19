class AddAkillToOmertaLoggerFamilies < ActiveRecord::Migration[4.2]
  def change
    add_column :omerta_logger_families, :akill, :boolean
  end
end
