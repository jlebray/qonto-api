# frozen_string_literal: true

module Qonto
  module APIOperations
    module List
      def list(params = {}, opts = {})
        params ||= {}
        opts[:client] ||= Qonto::Client.current_client

        response = request(:get, url, params, opts)
        parsed_body = JSON.parse(response.body) || {}

        Qonto::ListObject.new(
          parsed_body["#{self::OBJECT_NAME}s"].map { new(_1) } || [],
          parsed_body['meta'] || {},
          url,
          params,
          opts
        )
      end
    end
  end
end
