# frozen_string_literal: true

require 'json'

module Qonto
  module APIOperations
    module Retrieve
      def retrieve(id, params = {}, opts = {})
        params ||= {}
        opts[:client] ||= Qonto::Client.current_client

        response = request(:get, url(id), params, opts)
        parsed_body = JSON.parse(response.body)

        new(parsed_body[self::OBJECT_NAME])
      end
    end
  end
end
