module Helpers
  module Calculators
    class DiscountCalculator < Calculator
      def calculate(args={})
        args[:amount] * (1 - args[:discount_rate])
      end
    end
  end
end