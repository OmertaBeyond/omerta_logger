# This migration comes from omerta_logger (originally 20140826195246)
class AddOnlineTimeSecondsToOmertaLoggerUser < ActiveRecord::Migration
  def change
    add_column :omerta_logger_users, :online_time_seconds, :integer, default: 0
  end
end
