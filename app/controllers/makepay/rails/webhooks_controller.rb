module MakePay
  module Rails
    class WebhooksController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        payload = request.raw_post
        signature = request.headers["X-MakePay-Signature"]

        MakePay::Webhook.verify!(
          payload,
          signature,
          MakePay::Rails.configuration.webhook_secret
        )

        event = JSON.parse(payload)
        MakePay::Rails.configuration.webhook_handler.call(event, request)

        head :ok
      rescue JSON::ParserError
        render json: { error: "invalid_json" }, status: :bad_request
      rescue MakePay::WebhookVerificationError
        render json: { error: "invalid_signature" }, status: :unauthorized
      end
    end
  end
end
