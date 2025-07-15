# frozen_string_literal: true

module Thredded
  module UserPermissions
    module Write
      module ForumUsers
        extend ActiveSupport::Concern

        # @return [ActiveRecord::Relation<Thredded::Messageboard>] messageboards that the user can post in
        def thredded_can_write_messageboards
          forums = Thredded::ForumUser.where(user_detail: thredded_user_detail).map(&:forum)
          forums.flat_map(&:messageboards)
        end
      end
    end
  end
end
