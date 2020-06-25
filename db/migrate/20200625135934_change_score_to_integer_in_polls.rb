class ChangeScoreToIntegerInPolls < ActiveRecord::Migration[6.0]
  def change
    change_column :polls, :score, :integer, using: "score::integer"
  end
end
