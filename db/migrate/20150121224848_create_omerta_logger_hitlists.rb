class CreateOmertaLoggerHitlists < ActiveRecord::Migration
  def change
    create_table :omerta_logger_hitlists do |t|
      t.integer :ext_hitlist_id
      t.references :version
      t.datetime :date
      t.integer :amount
      t.belongs_to :target
      t.belongs_to :hitlister
    end
  end
end
