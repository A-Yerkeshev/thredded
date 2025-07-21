# frozen_string_literal: true

module Thredded
  class ForumPolicy
    # The scope of readable forums
    class Scope
      # @param user [Thredded.user_class]
      # @param scope [ActiveRecord::Relation<Thredded::Forum>]
      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      # @return [ActiveRecord::Relation<Thredded::Forum>]
      def resolve
        readable = @user.thredded_can_read_forums
        if readable == Thredded::Forum.all
          @scope
        else
          @scope.merge(readable)
        end
      end
    end

    # @param user [Thredded.user_class]
    # @param forum [Thredded::Forum]
    def initialize(user, forum)
      @user = user
      @forum = forum
    end

    def create?
      @user.thredded_admin?(@forum)
    end

    def read?
      @user.thredded_admin?(@forum) || @user.thredded_can_read_forum?(@forum)
    end

    def update?
      @user.thredded_admin?(@forum)
    end

    def destroy?
      @user.thredded_admin?(@forum)
    end

    def moderate?
      @user.thredded_admin?(@forum) || @user.thredded_can_moderate_forum?(@forum)
    end

    def post?
      @user.thredded_admin?(@forum) || @user.thredded_can_write_forums.include?(@forum)
    end
  end
end
