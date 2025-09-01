# frozen_string_literal: true

module Thredded
  module ForumOwner
    extend ActiveSupport::Concern

    included do
      has_many :forum_ownerships,
               as: :forum_owner,
               class_name: 'Thredded::ForumOwnership',
               dependent: :destroy,
               inverse_of: :forum_owner

      # Returns collection of owned forums
      # @return [ActiveRecord::Relation<Forum>]
      def forums
        Thredded::Forum.joins(:forum_ownerships)
          .where(thredded_forum_ownerships: {forum_owner_id: id, forum_owner_type: self.class.name})
      end
    end
  end
end