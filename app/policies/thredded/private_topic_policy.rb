# frozen_string_literal: true

module Thredded
  class PrivateTopicPolicy
    # @param user [Thredded.user_class]
    # @param private_topic [Thredded::PrivateTopic]
    def initialize(user, private_topic)
      @private_topic = private_topic
      @user = user

      if Thredded.multitenant
        @forum = private_topic.forum
        @forum_policy = Thredded::ForumPolicy.new(user, @forum)
      end
    end

    def create?
      return false if @forum && !@forum_policy.post?
      !@user.thredded_anonymous? && !@user.thredded_user_detail.blocked?
    end

    def read?
      @private_topic.users.include?(@user)
    end

    def update?
      return false if @forum && @forum.archived
      !@user.thredded_anonymous? && @user.id == @private_topic.user_id
    end
  end
end
