# frozen_string_literal: true

module Thredded
  module ForumOwner
    extend ActiveSupport::Concern

    included do
      has_one :forum,
      as: :forum_owner,
      class_name: 'Thredded::Forum',
      inverse_of: :forum_owner,
      dependent: :destroy
    end
  end
end