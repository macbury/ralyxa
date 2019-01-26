require 'json'
require 'forwardable'
require 'alexa_verifier'
require_relative './user'

module Ralyxa
  module RequestEntities
    class LambdaRequest < Request
      extend Forwardable
      INTENT_REQUEST_TYPE = 'IntentRequest'.freeze

      def_delegator :@user, :id, :user_id
      def_delegator :@user, :access_token, :user_access_token
      def_delegator :@user, :access_token_exists?, :user_access_token_exists?

      attr_reader :request

      def initialize(event, user_class = Ralyxa::RequestEntities::User)
        @request = event
        @user = user_class.build(@request)
      end

      private

      def validate_request(request)
        true
      end
      alias_method :attempt_to_rewind_request_body, :validate_request
    end
  end
end
