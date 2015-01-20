# This migration comes from omerta_logger (originally 20150120224051)
class CreateOmertaLoggerUserRevives < ActiveRecord::Migration
  def change
    create_table :omerta_logger_user_revives do |t|
      t.datetime :date
      t.references :user, index: true
    end
  end
end
