require "test_helper"

module ConektaPayment
  describe Pay do
    let(:pay) { Pay.new }

    it "must be valid" do
      pay.must_be :valid?
    end
  end
end
