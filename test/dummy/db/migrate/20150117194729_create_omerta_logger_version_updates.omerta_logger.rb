# This migration comes from omerta_logger (originally 20150117191359)
class CreateOmertaLoggerVersionUpdates < ActiveRecord::Migration
  def change
    create_table :omerta_logger_version_updates do |t|
      t.references :version, index: true
      t.datetime :generated
      t.float :duration
    end
  end
end
