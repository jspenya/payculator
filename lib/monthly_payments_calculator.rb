require_relative 'loader'

class MonthlyPaymentsCalculator
  def initialize(data:, data_loader: Helpers::DataLoader)
    @data = data_loader.new(data).load_data
  end

  attr_accessor :data

  def monthly_payments(course_id:, content_options_ids:, terms:)
    course = Helpers::Finder.for('courses', data['courses']).find_by_id(course_id)
    # TODO: Smell
    args = {
      course:,
      content_options_ids:,
      terms:,
      base_cost: course.base_cost,
      discount_rate: discount_rate(course:, terms:) }
    validator = Helpers::Payments::Validator.new(args:)

    errors = validator.validate
    return errors if errors.any?

    calculator = Helpers::Calculators::PaymentCalculator.new
    calculator.calculate(args:)
  end

  private

  def discount_rate(course:, terms:)
    course.find_payment_term(terms)&.discounted_value&.to_f
  end
end
