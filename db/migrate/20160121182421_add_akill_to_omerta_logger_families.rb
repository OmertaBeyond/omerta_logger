class AddAkillToOmertaLoggerFamilies < ActiveRecord::Migration
  def change
    add_column :omerta_logger_families, :akill, :boolean
  end
end
