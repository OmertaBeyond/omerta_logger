class AddArchiveUrlToOmertaLoggerDomain < ActiveRecord::Migration
  def change
    add_column :omerta_logger_domains, :archive_url, :string
  end
end
