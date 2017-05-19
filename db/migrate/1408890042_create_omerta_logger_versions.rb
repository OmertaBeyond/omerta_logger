class CreateOmertaLoggerVersions < ActiveRecord::Migration[4.2]
  def change
    create_table :omerta_logger_versions do |t|
      t.string :version
      t.references :domain, index: true
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
