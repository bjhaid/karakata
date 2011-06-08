class CreateInteractions < ActiveRecord::Migration
  def self.up
    drop_table :interactions do |t|
      t.integer :user_id
      t.integer :ref_id
      t.string :user_type

      t.timestamps
    end
  end

  def self.down
    drop_table :interactions
  end
end
