module Helpers
  module Calculators
    class OptionsCostCalculator < Calculator
      def calculate(args={})
        args[:course].content_options.sum do |content_option|
          content_option.options.sum do |option|
            args[:content_options_ids].include?(option.id) ? Money.to_cents(option.price) : 0
          end
        end
      end
    end
  end
end
