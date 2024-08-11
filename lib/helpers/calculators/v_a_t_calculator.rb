module Helpers
  module Calculators
    class VATCalculator < Calculator
      def calculate(vat: VAT, args: {})
        args[:amount] = args[:amount] * (1 + vat / 100.0)
        args
      end
    end
  end
end
