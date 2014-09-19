module ConektaPayment
  class PaymentError
    extend Forwardable
    def_delegators :@exception, :message, :message_to_purchaser, :code,
      :type, :param
    attr_reader :recoverable

    def initialize(exception, recoverable)
      @exception = exception
      @recoverable = recoverable
    end

    def to_s
      "#{@exception.class}::#{message} => [#{code}, #{param}]"
    end

    def to_hash
      base = {
        inner_class: inner_class,
        message: message
      }

      if @exception.respond_to?(:code)
        base.merge({
          message_to_purchaser: try(:message_to_purchaser),
          code: code,
          type: type,
          param: param
        })
      end
    end

    def inner_class
      @exception.class
    end
  end
end
