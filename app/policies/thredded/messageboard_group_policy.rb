# frozen_string_literal: true

module Thredded
  class MessageboardGroupPolicy
    # @param user [Thredded.user_class]
    # @param group [Thredded::MessageboardGroup]
    def initialize(user, group)
      @user = user
      @group = group
    end

    def create?
      thredded_admin?
    end

    private

    def thredded_admin?
      Thredded.multitenant ? @user.thredded_admin?(@group.forum) : @user.thredded_admin?
    end
  end
end
