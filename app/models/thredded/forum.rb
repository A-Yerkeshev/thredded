# frozen_string_literal: true

module Thredded
  class Forum < ActiveRecord::Base
    has_many :messageboard_groups,
             inverse_of: :forum,
             dependent: :destroy

    has_many :messageboards,
             inverse_of: :forum,
             dependent: :destroy

    # Finds forum by ID, or raises {Thredded::Errors::ForumNotFound}.
    # @param id [String, Number]
    # @return [Thredded::Forum]
    # @raise [Thredded::Errors::ForumNotFound] if forum with the given ID does not exist.
    def self.find!(id)
      find_by(id: id) || fail(Thredded::Errors::ForumNotFound)
    end
  end
end