# frozen_string_literal: true

PROJECT_ROOT = ::File.expand_path('../', __dir__)
require ::File.expand_path('../lib/qonto.rb', __dir__)
require 'test/unit'
require 'shoulda/context'
require 'webmock/test_unit'

WebMock.disable_net_connect!

module Test
  module Unit
    class TestCase
      setup do
        url = 'http://fake.qonto.test'
        login = 'a_login'
        secret_key = 'a_secret_key'
        Qonto::Client.current_client = Qonto::Client.new(url, login, secret_key)
      end

      private

      def client
        Qonto::Client.current_client
      end
    end
  end
end
