module MakePay
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace MakePay::Rails
      engine_name "makepay_rails"

      initializer "makepay_rails.filter_parameters" do |app|
        app.config.filter_parameters += [
          :makepay_token,
          :makepay_webhook_secret,
          :api_token,
          :webhook_secret
        ]
      end
    end
  end
end
