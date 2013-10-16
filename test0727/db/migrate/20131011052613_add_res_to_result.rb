class AddResToResult < ActiveRecord::Migration
  def change
    add_column :results, :res5, :string
    add_column :results, :res6, :string
    add_column :results, :res7, :string
    add_column :results, :res8, :string
    add_column :results, :res9, :string
    add_column :results, :res10, :string
  end
end
