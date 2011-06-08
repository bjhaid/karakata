class AddPhoneNoToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :phone_no, :string
  end

  def self.down
  end
end
