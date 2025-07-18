# frozen_string_literal: true

module Thredded
  module UserPermissions
    module Read
      module ForumUsers
        extend ActiveSupport::Concern
        included { extend ClassMethods }

        # @return [ActiveRecord::Relation<Thredded::Forum>] forums that the user can read
        def thredded_can_read_forums
          Thredded::ForumUser.where(user_detail: thredded_user_detail).map(&:forum)
        end

        # @param [Thredded::Forum] forum
        # @return [Boolean] Whether the user can read the given forum.
        def thredded_can_read_forum?(forum)
          scope = thredded_can_read_forums
          scope == Thredded::Forum.all || scope.include?(forum)
        end

        # @return [ActiveRecord::Relation<Thredded::Messageboard>] messageboards that the user can read
        def thredded_can_read_messageboards
          thredded_can_read_forums.flat_map(&:messageboards)
        end

        # @param [Thredded::Messageboard] messageboard
        # @return [Boolean] Whether the user can read the given messageboard.
        def thredded_can_read_messageboard?(messageboard)
          scope = thredded_can_read_messageboards
          scope == Thredded::Messageboard.all || scope.include?(messageboard)
        end

        module ClassMethods
          # Users that can read some of the given forums.
          #
          # @param _forums [Array<Thredded::Forum>]
          # @return [ActiveRecord::Relation<Thredded.user_class>] users that can read the given forums
          def thredded_forums_readers(_forums)
            _forums.flat_map { |forum| forum.forum_users.map(&:user_detail.user) }.uniq
          end

          # Users that can read some of the given messageboards.
          #
          # @param _messageboards [Array<Thredded::Messageboard>]
          # @return [ActiveRecord::Relation<Thredded.user_class>] users that can read the given messageboards
          def thredded_messageboards_readers(_messageboards)
            forums = _messageboards.map(&:forum).uniq
            forums.flat_map { |forum| forum.forum_users.map(&:user_detail.user) }.uniq
          end
        end
      end
    end
  end
end
