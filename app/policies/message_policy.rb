class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end
  def index_thread?
    true
  end
  def show?
    true
  end

  def create?
    true
  end

  def destroy?
    record.user == user
  end
end
