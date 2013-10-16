class AddResfrom21to30ToResult < ActiveRecord::Migration
  def change
    add_column :results, :res21, :string
    add_column :results, :res22, :string
    add_column :results, :res23, :string
    add_column :results, :res24, :string
    add_column :results, :res25, :string
    add_column :results, :res26, :string
    add_column :results, :res27, :string
    add_column :results, :res28, :string
    add_column :results, :res29, :string
    add_column :results, :res30, :string
  end
end
