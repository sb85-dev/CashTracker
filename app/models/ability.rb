# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, Account do |account|
      account.user == user || account.invites.where(user: user, status: 'accepted').exists?
    end

    can :manage, Account, user_id: user.id

    can :read, Transaction do |transaction|
      transaction.account.user == user || transaction.account.invites.where(user: user, status: 'accepted').exists?
    end

    can :manage, Transaction do |transaction|
      transaction.account.user == user
    end

    # can :read, Budget do |budget|
    #   budget.account.user == user || budget.account.invites.where(user: user, status: 'accepted').exists?
    # end

    # can :manage, Budget do |budget|
    #   budget.account.user == user
    # end
  end
end
