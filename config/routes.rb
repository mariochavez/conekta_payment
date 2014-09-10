ConektaPayment::Engine.routes.draw do
  get '/pagar' => 'pay#new', as: :pay, format: false
end
