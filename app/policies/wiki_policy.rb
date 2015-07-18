class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    attr_reader :user, :scope

    def initializer(user, scope)
      @user = user
      @scope = scope
    end

    def index?
      user.present?
    end

    def new?
      user.present?
    end

    def show?
      user.present?
    end

    def edit?
      update?
    end

    def update?
      user.present? && (record.user == user) || (user.admin?)
    end

    def destroy?
      user.present? && (record.user == user) || (user.admin?)
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
