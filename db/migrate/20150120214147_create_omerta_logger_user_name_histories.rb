class CreateOmertaLoggerUserNameHistories < ActiveRecord::Migration[4.2]
  def change
    create_table :omerta_logger_user_name_histories do |t|
      t.string :name
      t.datetime :date
      t.references :user, index: true
    end
  end
end
