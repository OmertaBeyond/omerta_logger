class CreateOmertaLoggerFamilyBankHistories < ActiveRecord::Migration
  def change
    create_table :omerta_logger_family_bank_histories do |t|
      t.datetime :date
      t.integer :bank
      t.references :family, index: true
    end
  end
end
