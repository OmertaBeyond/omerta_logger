class ChangeBankToBigintInOmertaLoggerFamilies < ActiveRecord::Migration[4.2]
  def change
    change_column :omerta_logger_families, :bank, :integer, :limit => 8
  end
end
