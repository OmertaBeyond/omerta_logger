# This migration comes from omerta_logger (originally 20150206231722)
class CreateOmertaLoggerFamilyBankHistories < ActiveRecord::Migration
  def change
    create_table :omerta_logger_family_bank_histories do |t|
      t.datetime :date
      t.integer :bank
      t.references :family, index: true
    end
  end
end
