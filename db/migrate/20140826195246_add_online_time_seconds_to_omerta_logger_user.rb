class AddOnlineTimeSecondsToOmertaLoggerUser < ActiveRecord::Migration[4.2]
  def change
    add_column :omerta_logger_users, :online_time_seconds, :integer, default: 0
  end
end
