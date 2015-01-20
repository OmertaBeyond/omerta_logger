# This migration comes from omerta_logger (originally 20150120214147)
class CreateOmertaLoggerUserNameHistories < ActiveRecord::Migration
  def change
    create_table :omerta_logger_user_name_histories do |t|
      t.string :name
      t.datetime :date
      t.references :user, index: true
    end
  end
end
