# frozen_string_literal: true

module Thredded
  class MessageboardGroupPolicy
    # @param user [Thredded.user_class]
    # @param group [Thredded::MessageboardGroup]
    def initialize(user, group)
      @user = user
      @group = group
      @forum_policy = Thredded::ForumPolicy.new(user, group.forum) if Thredded.multitenant
    end

    def create?
      @forum_policy ? @forum_policy.post? : @user.thredded_admin?
    end
  end
end
