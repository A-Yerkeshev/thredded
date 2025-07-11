# frozen_string_literal: true

module Thredded
  # The state of a user with regards to a forum. Used to control which users can access which forums.
  class ForumUser < ActiveRecord::Base
    belongs_to :forum,
               class_name:  'Thredded::Forum',
               foreign_key: :thredded_forum_id,
               inverse_of:  :forum_users
    belongs_to :user_detail,
               class_name: 'Thredded::UserDetail',
               foreign_key: :thredded_user_detail_id,
               inverse_of: :forum_users
  end
end