class CreateOmertaLoggerUserOnlineTimes < ActiveRecord::Migration[4.2]
  def change
    create_table :omerta_logger_user_online_times do |t|
      t.references :user, index: true
      t.datetime :start
      t.datetime :end
    end
  end
end
