require 'rack'

module Conekta
  class Server
    def call(env)
      [200, { "Content-Type" => 'application/json' }, [successful_payment.to_json]]
    end
  end
end
