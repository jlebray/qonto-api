# frozen_string_literal: true

module Qonto
  module APIOperations
    module List
      def list(params = {}, opts = {})
        params ||= {}
        opts[:client] ||= Qonto::Client.current_client

        response = request(:get, url, params)
        parsed_body = Oj.load(response.body) || {}

        Qonto::ListObject.new(
          parsed_body["#{self::OBJECT_NAME}s"] || [],
          parsed_body['meta'] || {},
          url,
          params,
          opts
        )
      end
    end
  end
end
