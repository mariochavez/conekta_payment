require 'rack'

module Conekta
  class Server
    def call(env)
      token = "#{env["QUERY_STRING"].match(/tok_\d{4}/)}"

      state, data = case token
      when 'tok_4242'
        [200, successful_payment.to_json]
      when 'tok_0829'
        [402, error_payment.to_json]
      when 'tok_9919'
        [400, {}.to_json]
      end

      [state, { "Content-Type" => 'application/json' }, [data]]
    end
  end
end
