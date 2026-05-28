module MakePay
  module Rails
    class WebhookJob < ActiveJob::Base
      queue_as :default

      def perform(event)
        MakePay::Rails.configuration.webhook_handler.call(event, nil)
      end
    end
  end
end
