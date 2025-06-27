# frozen_string_literal: true

module Thredded
  # The state of a user with regards to a forum. Used to control which users can access which forums.
  class ForumUser < ActiveRecord::Base
    belongs_to :forum, inverse_of: :forum_users
    validates :forum_id, presence: true

    belongs_to :user, class_name: Thredded.user_class_name, inverse_of: :forum_users
    validates :user_id, presence: true
  end
end