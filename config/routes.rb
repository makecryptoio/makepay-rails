MakePay::Rails::Engine.routes.draw do
  resources :payment_links, only: [:create]
  post "webhooks/makepay", to: "webhooks#create", as: :makepay_webhook
end
