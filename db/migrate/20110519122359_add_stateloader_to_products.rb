class AddStateloaderToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :stateloader, :string
  end

  def self.down
    remove_column :products, :stateloader
  end
end
