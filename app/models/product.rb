class Product < ActiveRecord::Base
  belongs_to :user
  has_many :assets, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  accepts_nested_attributes_for :assets, :allow_destroy => true
  has_attached_file :photo, 
     :styles => {
      :thumb => '50x50#',
      :large => '400x400#'
  }
      
  validates_presence_of :name, :message => 'Type in a product name'
  validates_presence_of :category, :message => 'Please choose a category'
  validates_presence_of :address, :message => 'Enter your address'
  validates_presence_of :state, :message => 'Choose a state'
  validates_numericality_of :phone_no, :message => 'Please enter a valid phone number' 
  validates_attachment_size :photo
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']  
  scope :from_users_followed_by, lambda { |user| followed_by(user) }

  private

   def self.from_users_followed_by(user)
    followed_ids = %(SELECT followed_id FROM relationships WHERE follower_id = :user_id)
    where("user_id IN (#{followed_ids}) OR user_id = ?, :user_id = :user_id", { :user_id => user})
  end
 end
