class ChangeAmountToBigintInOmertaLoggerHitlists < ActiveRecord::Migration[5.1]
  def change
    change_column :omerta_logger_hitlists, :amount, :integer, :limit => 8
  end
end
