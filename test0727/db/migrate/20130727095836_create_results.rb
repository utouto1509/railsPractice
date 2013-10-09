class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :keyword
      t.date :regist_date
      t.string :res1
      t.string :res2
      t.string :res3

      t.timestamps
    end
  end
end
