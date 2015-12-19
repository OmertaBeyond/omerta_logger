# This migration comes from omerta_logger (originally 20151219172438)
class ChangeBankToBigintInOmertaLoggerFamilyBankHistories < ActiveRecord::Migration
  def change
    change_column :omerta_logger_family_bank_histories, :bank, :integer, :limit => 8
  end
end
