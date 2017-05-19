class ChangeBankToBigintInOmertaLoggerFamilyBankHistories < ActiveRecord::Migration[4.2]
  def change
    change_column :omerta_logger_family_bank_histories, :bank, :integer, :limit => 8
  end
end
