class CreateVerdicts < ActiveRecord::Migration[6.0]
  def change
    create_table :verdicts do |t|
      t.float :lat
      t.float :long
      t.string :cuisine
      t.text :results

      t.timestamps
    end
  end
end
