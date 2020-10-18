# frozen_string_literal: true

require 'faraday'

# Operations
require 'qonto/api_operations/list'
require 'qonto/api_operations/request'
require 'qonto/api_operations/retrieve'

# Top level classes
require 'qonto/client'
require 'qonto/list_object'
require 'qonto/resource'

# Resources
require 'qonto/resources/bank_account'
require 'qonto/resources/organization'
require 'qonto/resources/transaction'

module Qonto
  def self.with_client(url, login, secret_key)
    Client.current_client = Client.new(url, login, secret_key)
    yield
  ensure
    Client.current_client = nil
  end
end
