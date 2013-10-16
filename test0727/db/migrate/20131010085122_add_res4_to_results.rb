class AddRes4ToResults < ActiveRecord::Migration
  def change
    add_column :results, :res4, :string
  end
end
