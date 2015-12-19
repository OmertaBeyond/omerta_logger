class ChangeBankToBigintInOmertaLoggerFamilies < ActiveRecord::Migration
  def change
    change_column :omerta_logger_families, :bank, :integer, :limit => 8
  end
end
