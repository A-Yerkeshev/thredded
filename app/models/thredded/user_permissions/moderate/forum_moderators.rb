# frozen_string_literal: true

module Thredded
  module UserPermissions
    module Moderate
      module ForumModerators
        extend ActiveSupport::Concern

        # @return [ActiveRecord::Relation<Thredded::Forum>] forums that the user can moderate
        def thredded_can_moderate_forums
          return Thredded::Forum.none unless send(Thredded.moderator_column)
          Thredded::ForumUser.where(user_detail: thredded_user_detail).map(&:forum)
        end

        # @param [Thredded::Forum] forum
        # @return [Boolean] Whether the user can moderate the given forum.
        def thredded_can_moderate_forum?(forum)
          scope = thredded_can_moderate_forums
          scope == Thredded::Forum.all || scope.include?(forum)
        end

        # @return [ActiveRecord::Relation<Thredded::Messageboard>] messageboards that the user can moderate
        def thredded_can_moderate_messageboards
          return Thredded::Messageboard.none unless send(Thredded.moderator_column)
          thredded_can_moderate_forums.flat_map(&:messageboards)
        end

        # @param [Thredded::Messageboard] messageboard
        # @return [Boolean] Whether the user can moderate the given messageboard.
        def thredded_can_moderate_messageboard?(messageboard)
          scope = thredded_can_moderate_messageboards
          scope == Thredded::Messageboard.all || scope.include?(messageboard)
        end
      end
    end
  end
end
