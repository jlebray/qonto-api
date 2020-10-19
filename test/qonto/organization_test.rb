# frozen_string_literal: true

require ::File.expand_path('../test_helper', __dir__)
ORGANIZATION_RESPONSE = DATA.read

module Qonto
  class OrganizationTest < Test::Unit::TestCase
    setup do
      @organization_id = 'potato-42'

      stub_request(:get, "#{client.url}/organizations/#{@organization_id}")
        .to_return(status: 200, body: ORGANIZATION_RESPONSE)
    end

    should 'be retrievable' do
      organization = Qonto::Organization.retrieve(@organization_id)
      assert_requested :get, "#{client.url}/organizations/#{@organization_id}"
      assert organization.is_a?(Qonto::Organization)
    end

    should 'have all the attributes' do
      organization = Qonto::Organization.retrieve(@organization_id)

      assert_equal organization.slug, 'potato-42'
      assert_equal organization.bank_accounts.size, 1

      bank_account = organization.bank_accounts.first

      assert bank_account.is_a?(Qonto::BankAccount)
      assert_equal bank_account.slug, 'potato-42'
      assert_equal bank_account.iban, 'FR123456789012'
      assert_equal bank_account.bic, 'ZZYYUIOLXXX'
      assert_equal bank_account.currency, 'EUR'
      assert_equal bank_account.balance, 12_850.08
      assert_equal bank_account.balance_cents, 1_285_008
      assert_equal bank_account.authorized_balance, 12_706.08
      assert_equal bank_account.authorized_balance_cents, 1_270_608
    end

    context '#to_h' do
      should 'serialize all the attributes' do
        organization = Qonto::Organization.retrieve(@organization_id)

        assert_equal(
          organization.to_h,
          {
            'slug' => 'potato-42',
            'bank_accounts' => [
              {
                'slug' => 'potato-42',
                'iban' => 'FR123456789012',
                'bic' => 'ZZYYUIOLXXX',
                'currency' => 'EUR',
                'balance' => 12_850.08,
                'balance_cents' => 1_285_008,
                'authorized_balance' => 12_706.08,
                'authorized_balance_cents' => 1_270_608
              }
            ]
          }
        )
      end
    end
  end
end

__END__
{
  "organization": {
    "slug": "potato-42",
    "bank_accounts": [
      {
        "slug": "potato-42",
        "iban": "FR123456789012",
        "bic": "ZZYYUIOLXXX",
        "currency": "EUR",
        "balance": 12850.08,
        "balance_cents": 1285008,
        "authorized_balance": 12706.08,
        "authorized_balance_cents": 1270608
      }
    ]
  }
}
