# frozen_string_literal: true

module Qonto
  module APIOperations
    module List
      def list(params = {})
        params ||= {}

        response = request(:get, url, params)
        parsed_body = Oj.load(response.body) || {}

        Qonto::ListObject.new(
          parsed_body["#{self::OBJECT_NAME}s"] || [],
          parsed_body['meta'] || {},
          url,
          params
        )
      end
    end
  end
end
