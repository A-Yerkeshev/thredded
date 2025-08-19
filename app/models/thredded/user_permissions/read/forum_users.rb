# frozen_string_literal: true

module Thredded
  module UserPermissions
    module Read
      module ForumUsers
        extend ActiveSupport::Concern
        included { extend ClassMethods }

        # @return [ActiveRecord::Relation<Thredded::Forum>] forums that the user can read
        def thredded_can_read_forums
          Thredded::Forum
            .joins(:forum_users)
            .where(thredded_forum_users: {thredded_user_detail_id: thredded_user_detail.id})
            .distinct
        end

        # @param [Thredded::Forum] forum
        # @return [Boolean] Whether the user can read the given forum.
        def thredded_can_read_forum?(forum)
          scope = thredded_can_read_forums
          scope == Thredded::Forum.all || scope.include?(forum)
        end

        # @return [ActiveRecord::Relation<Thredded::Messageboard>] messageboards that the user can read
        def thredded_can_read_messageboards
          Thredded::Messageboard.where(forum_id: thredded_can_read_forums.select(:id))
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
            Thredded.user_class
              .joins(thredded_user_detail: :forum_users)
              .where(thredded_forum_users: {forum_id: _forums.map(&:id)})
              .distinct
          end

          # Users that can read some of the given messageboards.
          #
          # @param _messageboards [Array<Thredded::Messageboard>]
          # @return [ActiveRecord::Relation<Thredded.user_class>] users that can read the given messageboards
          def thredded_messageboards_readers(_messageboards)
            Thredded.user_class
              .joins(thredded_user_detail: {forum_users: :forum})
              .where(thredded_forums: {id: Thredded::Forum.joins(:messageboards)
                                                          .where(thredded_messageboards: {id: _messageboards.map(&:id)})
                                                          .select(:id)})
              .distinct
          end
        end
      end
    end
  end
end
