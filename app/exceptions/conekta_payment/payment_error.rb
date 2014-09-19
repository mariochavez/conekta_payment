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
      "#{@exception.class}::#{message} => [#{code}, #{code}]"
    end

    def inner_class
      @exception.class
    end
  end
end
