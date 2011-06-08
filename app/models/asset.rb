class Asset < ActiveRecord::Base
  belongs_to :product
  has_attached_file :image,
    :styles => {
    :thumb => "50x50#",
    :large => "400x400#"
    }
end
