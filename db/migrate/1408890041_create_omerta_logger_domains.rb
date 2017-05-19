class CreateOmertaLoggerDomains < ActiveRecord::Migration[4.2]
  def change
    create_table :omerta_logger_domains do |t|
      t.string :name
      t.string :api_url

      t.timestamps
    end
  end
end
