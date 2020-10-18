# frozen_string_literal: true

module Qonto
  class Organization < Resource
    extend Qonto::APIOperations::Retrieve

    OBJECT_NAME = 'organization'
    ATTRIBUTES = %w[slug].freeze
    NESTED_ATTRIBUTES = {
      'bank_accounts' => Qonto::BankAccount
    }.freeze

    attr_accessor(*ATTRIBUTES, *NESTED_ATTRIBUTES.keys)
  end
end
