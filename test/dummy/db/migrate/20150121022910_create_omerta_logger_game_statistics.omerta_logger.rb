# This migration comes from omerta_logger (originally 20150121021408)
class CreateOmertaLoggerGameStatistics < ActiveRecord::Migration
  def change
    create_table :omerta_logger_game_statistics do |t|
      t.datetime :date
      t.references :version, index: true
      t.integer :users_total
      t.integer :users_alive
      t.integer :users_dead
      t.integer :lackeys_working
      t.integer :users_online_now
      t.integer :users_online_today
      t.integer :users_online_week
      t.integer :registrations_today
      t.integer :registrations_week
      t.integer :bullets, :limit => 8
      t.integer :money_pocket, :limit => 8
      t.integer :money_bank, :limit => 8
      t.integer :money_familybank, :limit => 8
      t.integer :honorpoints
      t.integer :car_attempts
      t.integer :crime_attempts
      t.integer :bustouts
      t.integer :cars
    end
  end
end
