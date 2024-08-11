module Helpers
  module Calculators
    class DiscountCalculator < Calculator
      def calculate(args: {})
        args[:amount] = (args[:base_cost] + args[:amount]) * (1 - args[:discount_rate])
        args
      end
    end
  end
end
