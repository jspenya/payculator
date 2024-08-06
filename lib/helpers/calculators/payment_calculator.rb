require "./lib/models/calculator"

module Helpers
  module Calculators
    class PaymentCalculator < Calculator
      def initialize(args={})
        @options_cost_calculator = args[:options_cost_calculator] ||= \
          OptionsCostCalculator.new

        @vat_calculator = args[:vat_calculator] ||= \
          VATCalculator.new
      end

      attr_accessor :options_cost_calculator, :vat_calculator

      def calculate(course:, content_options_ids:, terms:)
        base_cost = Money.parse_currency(course.base_cost)
        options_cost = options_cost_calculator.calculate(course: course, content_options_ids: content_options_ids)
        discounted_cost = apply_discount({ course:, terms:, amount: base_cost + options_cost })

        total_cost = vat_calculator.calculate(amount: discounted_cost)
        per_term_cost = total_cost / terms

        Money.format(per_term_cost)
      end

      private

      def apply_discount(args={})
        course = args[:course]
        amount = args[:amount]
        discount_rate = course.find_payment_term(args[:terms]).discounted_value.to_f

        DiscountCalculator.new.calculate(amount:, discount_rate:)
      end
    end
  end
end
