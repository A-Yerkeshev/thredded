# frozen_string_literal: true

module Thredded
  class Forum < ActiveRecord::Base
    has_many :messageboard_groups,
             inverse_of: :forum,
             dependent: :destroy

    has_many :messageboards,
             inverse_of: :forum,
             dependent: :destroy
  end
end