# frozen_string_literal: true

module Qonto
  class QontoError < StandardError
    attr_reader :message
    attr_reader :status
    attr_reader :body
    attr_reader :headers

    def initialize(message, status:, body:, headers:)
      @message = message
      @status = status
      @body = body
      @headers = headers
    end

    def ==(other)
      message == other.message &&
        status == other.status &&
        body == other.body &&
        headers == other.headers
    end
  end

  class APIError < QontoError; end
end
