# Security Policy

## Supported Versions

Security fixes are prepared for the latest tagged release and the `main` branch.

## Reporting A Vulnerability

Report suspected vulnerabilities to `info@makepay.io` with enough detail to reproduce the issue. Please avoid public disclosure until the MakePay team has confirmed impact and prepared a fix.

## Rails Integration Rules

- Keep MakePay API tokens in server-side Rails credentials or environment variables.
- Verify MakePay webhooks before changing invoice, order, subscription, or entitlement state.
- Keep `payment_link_authorizer` restrictive in production.
- Do not expose API tokens to views, logs, JavaScript, or client-side forms.
- Treat webhook handlers as idempotent.
