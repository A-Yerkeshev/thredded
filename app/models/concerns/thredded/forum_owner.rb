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

      # Returns array of owned forums
      # @return [Array<Forum>]
      def forums
        forum_ownerships.includes(:forum).map(&:forum)
      end
    end
  end
end