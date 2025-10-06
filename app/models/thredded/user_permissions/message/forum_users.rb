# frozen_string_literal: true

module Thredded
  module UserPermissions
    module Message
      module ForumUsers
        # @return [ActiveRecord::Relation<Thredded.user_class>] the users this user can include in a private topic
        def thredded_can_message_users(forum)
          Thredded.user_class.joins(:thredded_forum_users).where(thredded_forum_users: {forum_id: forum.id})
        end
      end
    end
  end
end
