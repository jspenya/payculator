require "./lib/models/calculator"

module Helpers
  module Calculators
    class PaymentCalculator < Calculator
      def initialize(calculator_run_sequence: Calculator::SEQUENCE)
        @calculator_run_sequence = calculator_run_sequence
      end

      attr_accessor :calculator_run_sequence

      def calculate(args: {})
        # The calculators' return value should be a hash
        # And contains the key :amount
        result = calculator_run_sequence.inject(args) do |hash, klass|
          Object.const_get("Helpers::Calculators::#{klass}").new.calculate(args: hash)
        end

        Money.from_cents(result[:amount]).format
      end
    end
  end
end
