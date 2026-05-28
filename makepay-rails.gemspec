require_relative "lib/makepay/rails/version"

Gem::Specification.new do |spec|
  spec.name = "makepay-rails"
  spec.version = MakePay::Rails::VERSION
  spec.authors = ["MakePay"]
  spec.email = ["info@makepay.io"]

  spec.summary = "Rails engine for MakePay checkout links and webhooks."
  spec.description = "Mountable Rails engine for server-side MakePay checkout creation, webhook verification, and payment-link workflows."
  spec.homepage = "https://github.com/makecryptoio/makepay-rails"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir[
    "app/**/*",
    "config/**/*",
    "lib/**/*.rb",
    "README.md",
    "LICENSE",
    "CHANGELOG.md"
  ]
  spec.require_paths = ["lib"]

  spec.add_dependency "makepay", "~> 0.1"
  spec.add_dependency "rails", ">= 7.1", "< 9.0"

  spec.add_development_dependency "rake", "~> 13.2"
end
