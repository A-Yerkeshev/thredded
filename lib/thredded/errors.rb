# frozen_string_literal: true

module Thredded
  class Error < StandardError
  end

  module Errors
    class DatabaseEmpty < Thredded::Error
      def message
        I18n.t('thredded.errors.database_empty')
      end
    end

    class LoginRequired < Thredded::Error
      def message
        I18n.t('thredded.errors.login_required')
      end
    end

    class UserNotFound < Thredded::Error
      def message
        I18n.t('thredded.errors.user_not_found')
      end
    end

    class PrivateTopicNotFound < Thredded::Error
      def message
        I18n.t('thredded.errors.private_topic_not_found')
      end
    end

    class PrivatePostNotFound < Thredded::Error
      def message
        I18n.t('thredded.errors.private_post_not_found')
      end
    end

    class TopicNotFound < Thredded::Error
      def message
        I18n.t('thredded.errors.topic_not_found')
      end
    end

    class PostNotFound < Thredded::Error
      def message
        I18n.t('thredded.errors.post_not_found')
      end
    end

    class MessageboardNotFound < Thredded::Error
      def message
        I18n.t('thredded.errors.messageboard_not_found')
      end
    end

    class MessageboardReadDenied < Thredded::Error
      def message
        I18n.t('thredded.errors.messageboard_read_denied')
      end
    end

    class MessageboardCreateDenied < Thredded::Error
      def message
        I18n.t('thredded.errors.messageboard_create_denied')
      end
    end

    class TopicCreateDenied < Thredded::Error
      def message
        I18n.t('thredded.errors.topic_create_denied')
      end
    end

    class PrivateTopicCreateDenied < Thredded::Error
      def message
        I18n.t('thredded.errors.private_topic_create_denied')
      end
    end

    class ForumNotFound < Thredded::Error
      def message
        I18n.t('thredded.errors.forum_not_found')
      end
    end
  end
end
