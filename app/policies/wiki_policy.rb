class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    def index?
      true
    end

    def destroy?
      #user.present? && (record.user == user || user.admin?)
    end

    def resolve
      scope
    end

  end
end
