# frozen_string_literal: true

module Qonto
  class Transaction < Resource
    extend Qonto::APIOperations::List

    OBJECT_NAME = 'transaction'
    ATTRIBUTES = %w[
      amount
      amount_cents
      attachment_ids
      attachment_lost
      attachment_required
      currency
      emitted_at
      initiator_id
      label
      label_ids
      local_amount
      local_amount_cents
      local_currency
      note
      operation_type
      reference
      settled_at
      side
      status
      transaction_id
      updated_at
      vat_amount
      vat_amount_cents
      vat_rate
    ].freeze

    attr_accessor(*ATTRIBUTES)
  end
end
