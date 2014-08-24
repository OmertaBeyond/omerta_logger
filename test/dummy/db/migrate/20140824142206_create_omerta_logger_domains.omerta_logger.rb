# This migration comes from omerta_logger (originally 1408890041)
class CreateOmertaLoggerDomains < ActiveRecord::Migration
  def change
    create_table :omerta_logger_domains do |t|
      t.string :name
      t.string :api_url

      t.timestamps
    end
  end
end
