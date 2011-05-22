class AddProductIdToStateloader < ActiveRecord::Migration
  def self.up
    add_column :stateloaders, :product_id, :integer
  end

  def self.down
    remove_column :stateloaders, :product_id
  end
end
