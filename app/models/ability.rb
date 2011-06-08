class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new

    if user.role? :client
      can :read, :all
      can :create, Product
      can :update, Product, :active => true, :user_id => user.id
    end
  end
end
