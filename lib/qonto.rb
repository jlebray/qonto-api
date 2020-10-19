# frozen_string_literal: true

require 'faraday'
require 'json'

# Operations
require_relative 'qonto/api_operations/list'
require_relative 'qonto/api_operations/request'
require_relative 'qonto/api_operations/retrieve'

# Top level classes
require_relative 'qonto/client'
require_relative 'qonto/list_object'
require_relative 'qonto/resource'
require_relative 'qonto/errors'

# Resources
require_relative 'qonto/resources/bank_account'
require_relative 'qonto/resources/organization'
require_relative 'qonto/resources/transaction'
require_relative 'qonto/resources/attachment'

module Qonto
  def self.with_client(url, login, secret_key)
    Client.current_client = Client.new(url, login, secret_key)
    yield
  ensure
    Client.current_client = nil
  end
end
