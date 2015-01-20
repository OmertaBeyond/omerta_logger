class CreateOmertaLoggerFamilyNameHistories < ActiveRecord::Migration
  def change
    create_table :omerta_logger_family_name_histories do |t|
      t.string :name
      t.datetime :date
      t.references :family, index: true
    end
  end
end
