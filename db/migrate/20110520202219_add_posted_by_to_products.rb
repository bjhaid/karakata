class AddPostedByToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :posted_by, :string
  end

  def self.down
    remove_column :products, :posted_by
  end
end
