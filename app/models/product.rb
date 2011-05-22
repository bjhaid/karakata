class Product < ActiveRecord::Base
  acts_as_mappable :default_units => :kms,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude
  belongs_to :user
  has_many :assets, :dependent => :destroy
  has_many :stateloaders
  accepts_nested_attributes_for :assets, :allow_destroy => true
  has_attached_file :photo, 
     :styles => {
      :thumb => '100x100#',
      :small => '300x300>',
      :large => '600x600>'
  }
  validates_presence_of :name
  validates_attachment_size :photo, :less_than => 200.kilobytes  
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']  
end
