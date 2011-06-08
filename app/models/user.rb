class User < ActiveRecord::Base
  validates_uniqueness_of :username
  has_many :assignments
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :products
  has_many :comments
  has_many :following, :through => :relationships, :source => :followed
  has_many :reverse_relationships, :foreign_key => "followed_id", :class_name => "Relationship", :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower

  def current_user?(user)
    current_user == user
  end

  def feed
    Product.from_users_followed_by(self)
  end

  def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end
  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :timeoutable and :omniauthable


  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me

  #Association between User and product, User owns products
  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }
  ROLES = %w[client]
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end
  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end
  def role?(role)
    roles.include? role.to_s
  end
  # def role?(role)
  #  return !!self.roles.find_by_name(role.to_s.camelize)
#  end
   ##   roles.include? roles.to_s
   #end
end
