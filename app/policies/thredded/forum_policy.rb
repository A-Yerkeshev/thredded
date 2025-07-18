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
      thredded_admin?
    end

    def read?
      thredded_admin? || @user.thredded_can_read_forum?(@forum)
    end

    def update?
      thredded_admin?
    end

    def destroy?
      thredded_admin?
    end

    def moderate?
      thredded_admin? || @user.thredded_can_moderate_forum?(@forum)
    end

    private

    def thredded_admin?
      @user.thredded_admin?(@forum)
    end
  end
end
