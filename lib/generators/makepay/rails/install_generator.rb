require "rails/generators"

module MakePay
  module Rails
    module Generators
      class InstallGenerator < ::Rails::Generators::Base
        source_root File.expand_path("templates", __dir__)

        def copy_initializer
          template "makepay.rb", "config/initializers/makepay.rb"
        end

        def show_routes
          route 'mount MakePay::Rails::Engine => "/makepay"'
        end
      end
    end
  end
end
