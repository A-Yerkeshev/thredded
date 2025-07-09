# frozen_string_literal: true

module Thredded
  class ForumOwnership < ActiveRecord::Base
    belongs_to :forum,
               class_name: 'Thredded::Forum',
               inverse_of: :forum_ownerships

    belongs_to :forum_owner,
               polymorphic: true,
               inverse_of: :forum_ownerships
  end
end