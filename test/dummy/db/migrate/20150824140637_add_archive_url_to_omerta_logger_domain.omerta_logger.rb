# This migration comes from omerta_logger (originally 20150822212616)
class AddArchiveUrlToOmertaLoggerDomain < ActiveRecord::Migration
  def change
    add_column :omerta_logger_domains, :archive_url, :string
  end
end
