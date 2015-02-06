# This migration comes from omerta_logger (originally 20150206223441)
class CreateOmertaLoggerFamilyUserCountHistories < ActiveRecord::Migration
  def change
    create_table :omerta_logger_family_user_count_histories do |t|
      t.datetime :date
      t.integer :user_count
      t.references :family, index: true
    end
  end
end
