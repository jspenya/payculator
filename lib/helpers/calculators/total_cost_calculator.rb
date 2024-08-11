module Helpers
  module Calculators
    class TotalCostCalculator < Calculator
      def calculate(args: {})
        args[:amount] = args[:amount] / args[:terms]
        args
      end
    end
  end
end
