require "makepay"
require "makepay/rails/version"
require "makepay/rails/configuration"

module MakePay
  module Rails
    class << self
      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield configuration
      end

      def client
        MakePay::Client.new(
          api_token: configuration.api_token,
          api_base_url: configuration.api_base_url
        )
      end
    end
  end
end

require "makepay/rails/engine" if defined?(::Rails)
