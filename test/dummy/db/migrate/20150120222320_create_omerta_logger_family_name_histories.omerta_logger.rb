# This migration comes from omerta_logger (originally 20150120221717)
class CreateOmertaLoggerFamilyNameHistories < ActiveRecord::Migration
  def change
    create_table :omerta_logger_family_name_histories do |t|
      t.string :name
      t.datetime :date
      t.references :family, index: true
    end
  end
end
