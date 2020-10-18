# Qonto API Ruby bindings

## Installation

```ruby
gem 'qonto-api'
```

## How to use

```ruby
::Qonto.with_client(base_url, login, secret_key) do
  org = Qonto::Organization.retrieve(login) # Qonto::Organization object
  org.bank_accounts.sum(&:balance) # Total balance

  Qonto::Transaction.list({
    status: "completed",
    settled_at_from: "2020-10-15T00:00:00.000Z",
    sort_by: "settled_at:asc",
  })
end
```

## TODO

- [ ] Add tests
- [ ] Better README
- [ ] Missing resources
