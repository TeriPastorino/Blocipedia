class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    attr_reader :user, :scope

    def initializer(user, scope)
      @user = user
      @scope = scope
    end

    def index?
      true
    end

    def show?
    end

    def destroy?
      #user.present? && (record.user == user || user.admin?)
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end

  end
end
