class User < ActiveRecord::Base
  validates_uniqueness_of :username
  has_many :assignments
  has_many :roles, :through => :assignments
  has_many :products
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
