module MakePay
  module Rails
    class PaymentLinksController < ApplicationController
      protect_from_forgery with: :exception

      def create
        unless MakePay::Rails.configuration.payment_link_authorizer.call(self)
          render json: { error: "unauthorized" }, status: :unauthorized
          return
        end

        checkout = MakePay::Rails.client.create_payment_link(
          amount_minor: payment_link_params.fetch(:amount_minor).to_i,
          currency: payment_link_params.fetch(:currency),
          external_id: payment_link_params.fetch(:external_id),
          description: payment_link_params[:description],
          metadata: MakePay::Rails.configuration.payment_link_metadata.call(self).merge(
            "rails_controller" => self.class.name
          )
        )

        render json: {
          checkout_url: checkout["checkoutUrl"],
          session_id: checkout["sessionId"],
          payment_id: checkout["paymentId"]
        }, status: :created
      rescue KeyError => error
        render json: { error: error.message }, status: :unprocessable_entity
      rescue MakePay::Error => error
        render json: { error: error.message }, status: :bad_gateway
      end

      private

      def payment_link_params
        params.require(:payment_link).permit(
          :amount_minor,
          :currency,
          :external_id,
          :description
        )
      end
    end
  end
end
