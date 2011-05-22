class Asset < ActiveRecord::Base
  belongs_to :product
  has_attached_file :image,
    :styles => {
    :thumb=> "100x100#",
    }
end
