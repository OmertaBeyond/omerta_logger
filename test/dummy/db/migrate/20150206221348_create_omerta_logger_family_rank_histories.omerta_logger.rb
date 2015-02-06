# This migration comes from omerta_logger (originally 20150206221017)
class CreateOmertaLoggerFamilyRankHistories < ActiveRecord::Migration
  def change
    create_table :omerta_logger_family_rank_histories do |t|
      t.datetime :date
      t.integer :rank
      t.references :family, index: true
    end
  end
end
