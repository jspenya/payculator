module Helpers
  module Calculators
    class OptionsCostCalculator < Calculator
      def calculate(course:, content_options_ids:)
        course.content_options.sum do |content_option|
          content_option.options.sum do |option|
            content_options_ids.include?(option.id) ? parse_cents(option.price) : 0
          end
        end
      end
    end
  end
end
