class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new

    if user.role? :client
      can :update, Product do |product|
      product.try(:user) == user
      end
    end
  end
end
