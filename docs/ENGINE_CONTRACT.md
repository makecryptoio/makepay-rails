# Engine Contract

## Configuration

The engine exposes:

- `api_base_url`
- `api_token`
- `webhook_secret`
- `payment_link_authorizer`
- `payment_link_metadata`
- `webhook_handler`

## Mounted Routes

When mounted at `/makepay`:

- `POST /payment_links`
- `POST /webhooks/makepay`

## Webhook Handling

The webhook route verifies `X-MakePay-Signature` using the base `makepay` gem. Only verified payloads are parsed and passed into `webhook_handler`.

Handlers should be idempotent and should persist payment state in the host Rails app.
