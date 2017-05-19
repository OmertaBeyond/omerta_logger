class CreateOmertaLoggerVersionUpdates < ActiveRecord::Migration[4.2]
  def change
    create_table :omerta_logger_version_updates do |t|
      t.references :version, index: true
      t.datetime :generated
      t.float :duration
    end
  end
end
