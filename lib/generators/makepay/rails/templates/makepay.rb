MakePay::Rails.configure do |config|
  config.api_base_url = ENV.fetch("MAKEPAY_API_BASE_URL", "https://api.makepay.io")
  config.api_token = ENV.fetch("MAKEPAY_TOKEN")
  config.webhook_secret = ENV.fetch("MAKEPAY_WEBHOOK_SECRET")

  config.payment_link_authorizer = lambda do |controller|
    controller.respond_to?(:current_user, true) && controller.send(:current_user).present?
  end

  config.payment_link_metadata = lambda do |controller|
    user = controller.send(:current_user) if controller.respond_to?(:current_user, true)
    user ? { "rails_user_id" => user.id.to_s } : {}
  end

  config.webhook_handler = lambda do |event, _request|
    Rails.logger.info("MakePay webhook received: #{event.fetch('id', 'unknown')}")
  end
end
