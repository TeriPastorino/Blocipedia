class WikiPolicy < ApplicationPolicy
  def new?
    user.present?
  end

  def update?
    user.present?
  end

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end

  def create_private?
    user.present? && (user.premium? || user.admin?)
  end

  def show?
    if user.present?
      if user.premium? || user.admin?
        record.public? || record.user == user || record.users.include?(user)
      elsif user.standard?
        record.public? || record.users.include?(user)
      end
    else
      record.public?
    end
  end
end