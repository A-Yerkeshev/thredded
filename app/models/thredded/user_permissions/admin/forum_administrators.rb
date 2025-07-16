# frozen_string_literal: true

module Thredded
  module UserPermissions
    module Admin
      module ForumAdministrators
        # @return [boolean] Whether this user has full admin rights on Thredded's forum.
        def thredded_admin?(forum)
          send(Thredded.admin_column) && Thredded::ForumUser.find_by(
                                          thredded_forum_id: forum.id, thredded_user_detail_id: thredded_user_detail.id)
        end
      end
    end
  end
end
