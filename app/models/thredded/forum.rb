# frozen_string_literal: true

module Thredded
  class Forum < ActiveRecord::Base
    has_many :forum_ownerships,
             inverse_of: :forum,
             dependent: :destroy

    has_many :messageboard_groups,
             inverse_of: :forum,
             dependent: :destroy

    has_many :messageboards,
             inverse_of: :forum,
             dependent: :destroy

    has_many :private_topics,
             inverse_of: :forum,
             dependent: :destroy

    has_many :forum_users,
             inverse_of:  :forum,
             foreign_key: :thredded_forum_id,
             dependent: :destroy

    validates :name,
              length: { maximum: Thredded.forum_name_max_length }

    # Finds forum by ID, or raises {Thredded::Errors::ForumNotFound}.
    # @param id [String, Number]
    # @return [Thredded::Forum]
    # @raise [Thredded::Errors::ForumNotFound] if forum with the given ID does not exist.
    def self.find!(id)
      find_by(id: id) || fail(Thredded::Errors::ForumNotFound)
    end

    # Returns array of forum's owners
    # @return [Array<ForumOwner>]
    def owners
      forum_ownerships.includes(:forum_owner).map(&:forum_owner)
    end
  end
end