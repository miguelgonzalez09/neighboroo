class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end
  def new?
    true
  end
  def create?
    true
  end
  def edit?
    update?
  end
  def update?
    record.user == user
  end
  def destroy?
    record.user == user
  end
  def user_items?
    true
  end
end
