# frozen_string_literal: true

require ::File.expand_path('../test_helper', __dir__)
TRANSACTIONS_RESPONSE = DATA.read

module Qonto
  class TransactionTest < Test::Unit::TestCase
    setup do
      stub_request(:get, "#{client.url}/transactions")
        .to_return(status: 200, body: TRANSACTIONS_RESPONSE)
    end

    should 'be listable' do
      transactions = Qonto::Transaction.list
      assert_requested :get, "#{client.url}/transactions"
      assert transactions.data.is_a?(Array)
      assert transactions.data[0].is_a?(Qonto::Transaction)
      assert_equal transactions.data.size, 2
    end

    should 'have all the attributes' do
      transaction = Qonto::Transaction.list.data[0]

      assert_equal transaction.transaction_id, 'an_id_1'
      assert_equal transaction.amount, 10.8
      assert_equal transaction.amount_cents, 1080
      assert_equal transaction.attachment_ids, ['4954363a-6771']
      assert_equal transaction.local_amount, 10.8
      assert_equal transaction.local_amount_cents, 1080
      assert_equal transaction.side, 'debit'
      assert_equal transaction.operation_type, 'qonto_fee'
      assert_equal transaction.currency, 'USD'
      assert_equal transaction.local_currency, 'USD'
      assert_equal transaction.label, 'Qonto'
      assert_equal transaction.settled_at, '2019-11-15T05:44:15.000Z'
      assert_equal transaction.emitted_at, '2019-11-15T05:44:08.777Z'
      assert_equal transaction.updated_at, '2019-11-15T06:41:58.934Z'
      assert_equal transaction.status, 'completed'
      assert_equal transaction.note, 'a_note'
      assert_equal transaction.reference, 'a_reference'
      assert_equal transaction.vat_amount, 1.8
      assert_equal transaction.vat_amount_cents, 180
      assert_equal transaction.vat_rate, 20.0
      assert_equal transaction.initiator_id, 31
      assert_equal transaction.label_ids, [42]
      assert_equal transaction.attachment_lost, false
      assert_equal transaction.attachment_required, true
    end

    context '#to_h' do
      should 'serialize all the attributes' do
        transaction = Qonto::Transaction.list.data[0]
        assert_equal(
          transaction.to_h,
          {
            'transaction_id' => 'an_id_1',
            'amount' => 10.8,
            'amount_cents' => 1080,
            'attachment_ids' => [
              '4954363a-6771'
            ],
            'local_amount' => 10.8,
            'local_amount_cents' => 1080,
            'side' => 'debit',
            'operation_type' => 'qonto_fee',
            'currency' => 'USD',
            'local_currency' => 'USD',
            'label' => 'Qonto',
            'settled_at' => '2019-11-15T05:44:15.000Z',
            'emitted_at' => '2019-11-15T05:44:08.777Z',
            'updated_at' => '2019-11-15T06:41:58.934Z',
            'status' => 'completed',
            'note' => 'a_note',
            'reference' => 'a_reference',
            'vat_amount' => 1.8,
            'vat_amount_cents' => 180,
            'vat_rate' => 20.0,
            'initiator_id' => 31,
            'label_ids' => [42],
            'attachment_lost' => false,
            'attachment_required' => true
          }
        )
      end
    end
  end
end

__END__
{
  "transactions": [
    {
      "transaction_id": "an_id_1",
      "amount": 10.8,
      "amount_cents": 1080,
      "attachment_ids": [
        "4954363a-6771"
      ],
      "local_amount": 10.8,
      "local_amount_cents": 1080,
      "side": "debit",
      "operation_type": "qonto_fee",
      "currency": "USD",
      "local_currency": "USD",
      "label": "Qonto",
      "settled_at": "2019-11-15T05:44:15.000Z",
      "emitted_at": "2019-11-15T05:44:08.777Z",
      "updated_at": "2019-11-15T06:41:58.934Z",
      "status": "completed",
      "note": "a_note",
      "reference": "a_reference",
      "vat_amount": 1.8,
      "vat_amount_cents": 180,
      "vat_rate": 20.0,
      "initiator_id": 31,
      "label_ids": [42],
      "attachment_lost": false,
      "attachment_required": true
    },
    {
      "transaction_id": "an_id_2",
      "amount": 43.68,
      "amount_cents": 4368,
      "attachment_ids": [],
      "local_amount": 43.68,
      "local_amount_cents": 4368,
      "side": "debit",
      "operation_type": "card",
      "currency": "EUR",
      "local_currency": "EUR",
      "label": "GOOGLE *GSUITE_lestudi",
      "settled_at": "2019-11-05T04:34:41.000Z",
      "emitted_at": "2019-11-01T17:08:30.000Z",
      "updated_at": "2019-11-05T13:01:07.607Z",
      "status": "completed",
      "note": null,
      "reference": "bonjour",
      "vat_amount": null,
      "vat_amount_cents": null,
      "vat_rate": null,
      "initiator_id": "b1070d90-1477-4c39-ae46-06e737176dac",
      "label_ids": [],
      "attachment_lost": false,
      "attachment_required": true
    }
  ],
  "meta": {
    "current_page": 1,
    "next_page": null,
    "prev_page": null,
    "total_pages": 1,
    "total_count": 2,
    "per_page": 100
  }
}
