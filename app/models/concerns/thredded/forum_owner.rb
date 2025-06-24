# frozen_string_literal: true

module Thredded
  module ForumOwner
    extend ActiveSupport::Concern

    included do
      has_many :forums
    end
  end
end