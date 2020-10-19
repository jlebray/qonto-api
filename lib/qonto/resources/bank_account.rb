# frozen_string_literal: true

module Qonto
  class BankAccount < Resource
    ATTRIBUTES = %w[
      slug
      iban
      bic
      currency
      balance
      balance_cents
      authorized_balance
      authorized_balance_cents
    ].freeze

    attr_accessor(*ATTRIBUTES)
  end
end
