# frozen_string_literal: true

module Thredded
  class MessageboardPolicy
    # The scope of readable messageboards
    class Scope
      # @param user [Thredded.user_class]
      # @param scope [ActiveRecord::Relation<Thredded::Messageboard>]
      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      # @return [ActiveRecord::Relation<Thredded::Messageboards>]
      def resolve
        readable = @user.thredded_can_read_messageboards
        if readable == Thredded::Messageboard.all
          @scope
        else
          @scope.merge(readable)
        end
      end
    end

    # @param user [Thredded.user_class]
    # @param messageboard [Thredded::Messageboard]
    def initialize(user, messageboard)
      @user = user
      @messageboard = messageboard
      @forum_policy = Thredded::ForumPolicy.new(user, messageboard.forum) if Thredded.multitenant
    end

    def create?
      @forum_policy ? @forum_policy.post? : thredded_admin?
    end

    def read?
      if @forum_policy
        @forum_policy.read?
      else
        thredded_admin? || @user.thredded_can_read_messageboard?(@messageboard)
      end
    end

    def update?
      thredded_admin?
    end

    def destroy?
      thredded_admin?
    end

    def post?
      if @forum_policy
        @forum_policy.post?
      else
        thredded_admin? ||
        (!@messageboard.locked? || moderate?) &&
          @user.thredded_can_write_messageboards.include?(@messageboard)
      end
    end

    def moderate?
      if @forum_policy
        @forum_policy.moderate?
      else
        thredded_admin? || @user.thredded_can_moderate_messageboard?(@messageboard)
      end
    end

    private

    def thredded_admin?
      Thredded.multitenant ? @user.thredded_admin?(@messageboard.forum) : @user.thredded_admin?
    end
  end
end
