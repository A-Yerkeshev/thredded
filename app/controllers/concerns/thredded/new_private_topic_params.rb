# frozen_string_literal: true

module Thredded
  # @api private
  module NewPrivateTopicParams
    protected

    def new_private_topic_params
      permitted_attrs = [:title, :content, :user_names, {user_ids: []}]
      permitted_attrs << :forum_id if Thredded.multitenant

      params
        .fetch(:private_topic, {})
        .tap { |p| adapt_user_ids! p }
        .permit(*permitted_attrs)
        .merge(user: thredded_current_user)
    end

    private

    # Allow a string of IDs joined with commas.
    def adapt_user_ids!(p)
      p[:user_ids] = p[:user_ids].split(',') if p[:user_ids].is_a?(String)
    end
  end
end
