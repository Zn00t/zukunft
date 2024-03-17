class ChangeSumsHistoryToHistoricalSums < ActiveRecord::Migration[6.1]
  def change
    rename_table :sums_history, :historical_sums
  end
end
