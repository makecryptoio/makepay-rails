module MakePay
  module Rails
    class Configuration
      attr_accessor :api_base_url,
                    :api_token,
                    :webhook_secret,
                    :webhook_handler,
                    :payment_link_authorizer,
                    :payment_link_metadata

      def initialize
        @api_base_url = "https://api.makepay.io"
        @api_token = nil
        @webhook_secret = nil
        @webhook_handler = lambda { |_event, _request| }
        @payment_link_authorizer = lambda { |_controller| true }
        @payment_link_metadata = lambda { |_controller| {} }
      end
    end
  end
end
