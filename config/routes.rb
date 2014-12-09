ConektaPayment::Engine.routes.draw do
  get '/preview/:id' => 'preview#show'
  get '/pagar' => 'pay#new', format: false, as: :pay_root

  resource :pay, controller: :pay, path: 'pagar',
    format: false, only: [:new, :create]
end
