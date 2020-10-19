# frozen_string_literal: true

module Qonto
  module APIOperations
    module Request
      ALLOWED_METHODS = %w[get post delete head trace].freeze

      module ClassMethods
        def request(method, url, params = {}, opts = {})
          params ||= {}

          error_on_invalid_params(params)

          client = opts[:client]
          headers = client.authorization_header

          response = faraday_method(method).call(url, params, headers)
          raise error_from_response(response) if response.status >= 400

          response
        end

        private

        def error_on_invalid_params(params)
          return if params.nil? || params.is_a?(Hash)

          raise ArgumentError, 'request params should be either a Hash or nil ' \
            "(was a #{params.class})"
        end

        def error_from_response(response)
          message =
            begin
              JSON.parse(response.body).dig('error_model', 'message')
            rescue JSON::ParserError # rubocop:disable Lint/SuppressedException
            end

          message ||= 'An unexpected error occured'

          raise Qonto::APIError.new(
            message,
            status: response.status,
            headers: response.headers,
            body: response.body
          )
        end

        def faraday_method(method)
          return Faraday.method(method) if ALLOWED_METHODS.include?(method.to_s)

          raise ArgumentError, 'request method should be one of ' \
            "#{ALLOWED_METHODS.join(', ').upcase}"
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      protected

      def request(method, url, params = {})
        self.class.request(method, url, params)
      end
    end
  end
end
