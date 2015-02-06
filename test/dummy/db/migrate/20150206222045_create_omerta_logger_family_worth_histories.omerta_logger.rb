# This migration comes from omerta_logger (originally 20150206221913)
class CreateOmertaLoggerFamilyWorthHistories < ActiveRecord::Migration
  def change
    create_table :omerta_logger_family_worth_histories do |t|
      t.datetime :date
      t.integer :worth
      t.references :family, index: true
    end
  end
end
