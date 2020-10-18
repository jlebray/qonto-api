# frozen_string_literal: true

require 'json'

module Qonto
  module APIOperations
    module Retrieve
      def retrieve(id, params = {})
        params ||= {}

        response = request(:get, url(id), params)
        parsed_body = Oj.load(response.body)

        new(parsed_body[self::OBJECT_NAME])
      end
    end
  end
end
