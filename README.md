# MakePay Rails

Mountable Rails engine for MakePay checkout links and webhook verification.

This engine builds on the `makepay` Ruby gem and adds Rails-native routes, controllers, configuration, and an install generator.

## Install

```ruby
gem "makepay"
gem "makepay-rails"
```

Run the generator:

```bash
bin/rails generate makepay:rails:install
```

The generator creates `config/initializers/makepay.rb` and mounts the engine:

```ruby
mount MakePay::Rails::Engine => "/makepay"
```

## Routes

Mounted at `/makepay`, the engine provides:

- `POST /makepay/payment_links` - create a checkout link from server-side Rails code.
- `POST /makepay/webhooks/makepay` - verify and receive MakePay webhooks.

## Create Payment Links

```bash
curl -X POST http://localhost:3000/makepay/payment_links \
  -H "Content-Type: application/json" \
  -d '{"payment_link":{"amount_minor":1999,"currency":"USD","external_id":"order_123","description":"Order #123"}}'
```

## Webhook Handling

```ruby
MakePay::Rails.configure do |config|
  config.webhook_handler = lambda do |event, request|
    # Mark invoices paid, grant credits, or enqueue app-specific jobs here.
  end
end
```

The webhook controller verifies the `X-MakePay-Signature` header before invoking your handler.

## Development

```bash
node scripts/validate.mjs
ruby -c lib/makepay/rails.rb
gem build makepay-rails.gemspec
```

Full controller tests should run inside a host Rails application or dummy app once the base `makepay` gem is published.
