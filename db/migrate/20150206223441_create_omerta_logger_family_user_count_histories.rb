class CreateOmertaLoggerFamilyUserCountHistories < ActiveRecord::Migration[4.2]
  def change
    create_table :omerta_logger_family_user_count_histories do |t|
      t.datetime :date
      t.integer :user_count
      t.references :family, index: true
    end
  end
end
