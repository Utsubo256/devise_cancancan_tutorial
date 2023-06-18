# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # roleがadminのユーザーはモデル操作ができて管理者画面を閲覧可能
    if user.has_role?(:admin)
      can :manage, :all
      can :access_admin_page, :all

    # roleがmanagerのユーザーはモデル操作ができるが、管理者画面は閲覧不可能
    elseif user.has_role?(:manager)
      can :manage, :all
      cannot :access_admin_page, :all

    # roleがread_onlyのユーザーはモデル操作ができず、管理者画面は閲覧不可能
    elsif user.has_role?(:read_only)
      can :read, :all
      cannot :access_admin_page, :all

    # roleを持っていないユーザーは全ての画面が閲覧不可能
    else
      cannot :read, :all
    end
  end
end
