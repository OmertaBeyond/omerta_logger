class CreateOmertaLoggerUserRevives < ActiveRecord::Migration[4.2]
  def change
    create_table :omerta_logger_user_revives do |t|
      t.datetime :date
      t.references :user, index: true
    end
  end
end
