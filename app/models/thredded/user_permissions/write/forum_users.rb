# frozen_string_literal: true

module Thredded
  module UserPermissions
    module Write
      module ForumUsers
        extend ActiveSupport::Concern

        # @return [ActiveRecord::Relation<Thredded::Forum>] forums that the user can post in
        def thredded_can_write_forums
          Thredded::Forum
            .joins(:forum_users)
            .where(thredded_forum_users: {thredded_user_detail_id: thredded_user_detail.id})
            .distinct
        end

        # @return [ActiveRecord::Relation<Thredded::Messageboard>] messageboards that the user can post in
        def thredded_can_write_messageboards
          Thredded::Messageboard.where(forum_id: thredded_can_write_forums.select(:id))
        end
      end
    end
  end
end
