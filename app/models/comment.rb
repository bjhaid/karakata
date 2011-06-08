class Comment < ActiveRecord::Base
  attr_accessible :product_id, :comment
  belongs_to :product
  belongs_to :user
end
