# frozen_string_literal: true

module Qonto
  class Client
    class << self
      attr_accessor :current_client
    end

    attr_accessor :url, :login, :secret_key

    def initialize(url, login, secret_key)
      self.url = url
      self.login = login
      self.secret_key = secret_key
    end

    def authorization_header
      { Authorization: "#{login}:#{secret_key}" }
    end
  end
end
