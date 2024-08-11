require "./lib/models/calculator"

module Helpers
  module Calculators
    class PaymentCalculator < Calculator
      def initialize(options_cost_calculator: OptionsCostCalculator, vat_calculator: VATCalculator)
        @options_cost_calculator = options_cost_calculator.new
        @vat_calculator = vat_calculator.new
      end

      attr_accessor :options_cost_calculator, :vat_calculator

      def calculate(course:, content_options_ids:, terms:)
        base_cost = parse_cents(course.base_cost)
        options_cost = options_cost_calculator.calculate(course: course, content_options_ids: content_options_ids)
        discounted_cost = apply_discount(course:, terms:, amount: base_cost + options_cost)

        total_cost = vat_calculator.calculate(amount: discounted_cost)
        per_term_cost = total_cost / terms

        Money.from_cents(per_term_cost).format
      end

      private

      def apply_discount(course:, amount:, terms:)
        discount_rate = course.find_payment_term(terms).discounted_value.to_f

        DiscountCalculator.new.calculate(amount:, discount_rate:)
      end
    end
  end
end
