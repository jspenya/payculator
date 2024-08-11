module Helpers
  module Calculators
    class DiscountCalculator < Calculator
      def calculate(amount:, discount_rate:)
        amount * (1 - discount_rate)
      end
    end
  end
end
