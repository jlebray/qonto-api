# frozen_string_literal: true

module Qonto
  class Resource
    include Qonto::APIOperations::Request

    ATTRIBUTES = [].freeze
    NESTED_ATTRIBUTES = {}.freeze

    def self.url(id = nil)
      base_url = "#{Qonto::Client.current_client.url}/#{self::OBJECT_NAME}s"
      return base_url unless id

      "#{base_url}/#{id}"
    end

    def initialize(data)
      self.class::ATTRIBUTES.each do |attr|
        public_send("#{attr}=", data[attr])
      end

      self.class::NESTED_ATTRIBUTES.each do |attr, klass|
        public_send(
          "#{attr}=",
          (data[attr] || []).map { klass.new(_1) }
        )
      end
    end
  end
end
