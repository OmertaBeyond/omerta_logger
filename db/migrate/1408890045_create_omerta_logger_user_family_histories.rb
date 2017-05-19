class CreateOmertaLoggerUserFamilyHistories < ActiveRecord::Migration[4.2]
  def change
    create_table :omerta_logger_user_family_histories do |t|
      t.references :user, index: true
      t.references :family, index: true
      t.datetime :date
      t.integer :family_role
    end
  end
end
