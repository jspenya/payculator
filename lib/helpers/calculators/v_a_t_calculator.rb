module Helpers
  module Calculators
    class VATCalculator < Calculator
      def initialize(vat=20.0)
        @vat = vat
      end

      attr_accessor :vat

      def calculate(amount:)
        amount * (1 + vat / 100.0)
      end
    end
  end
end
