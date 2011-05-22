class AddStateToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :state, :string
  end

  def self.down
    remove_column :products, :state
  end
end
