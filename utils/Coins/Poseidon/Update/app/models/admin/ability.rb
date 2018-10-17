module Admin
  class Ability
    include CanCan::Ability

    def initialize(user)
      return unless user.admin?

      can :read, Order
      can :read, Trade
      can :read, Proof
      can :update, Proof
      can :manage, Document
      can :manage, Member
      can :manage, Ticket
      can :manage, IdDocument
      can :manage, TwoFactor

      can :menu, Deposit
      can :manage, ::Deposits::Bank
      can :manage, ::Deposits::Satoshi
      can :manage, ::Deposits::Zenbitex
      can :manage, ::Deposits::Doge
      can :manage, ::Deposits::Ltc
      can :manage, ::Deposits::Ether
      can :manage, ::Deposits::Poseidon
      #deposit

      can :menu, Withdraw
      can :manage, ::Withdraws::Bank
      can :manage, ::Withdraws::Satoshi
      can :manage, ::Withdraws::Zenbitex
      can :manage, ::Withdraws::Doge
      can :manage, ::Withdraws::Ltc
      can :manage, ::Withdraws::Ether
      can :manage, ::Withdraws::Poseidon
      #withdraw

    end
  end
end
