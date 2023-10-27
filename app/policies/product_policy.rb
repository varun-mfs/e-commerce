class ProductPolicy < ApplicationPolicy
  attr_reader :user, :product

  def initialize(user, product)
    @user = user
    @product = product
  end
  
  # class Scope < Scope
  #   # NOTE: Be explicit about which records you allow access to!
  #   # def resolve
  #   #   scope.all
  #   # end
  # end
  def index?
    user.admin?
  end

  # def new?
  #   user.admin?
  # end

  # def create?
  #   user.admin?
  # end

  # def edit?
  #   user.admin?
  # end

  # def update?
  #   user.admin?
  # end

  # def destroy?
  #   user.admin?
  # end
end
