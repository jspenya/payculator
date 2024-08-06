require_relative 'loader'

class MonthlyPaymentsCalculator
  def initialize(data:, data_loader: Helpers::DataLoader)
    @data = data_loader.new(data).load_data
  end

  attr_accessor :data

  def monthly_payments(course_id:, content_options_ids:, terms:)
    course = Helpers::Finder.for('courses', data['courses']).find_by_id(course_id)
    validator = Helpers::Payments::Validator.new(course: course, content_options_ids: content_options_ids, terms: terms)

    errors = validator.validate
    return errors if errors.any?

    calculator = Helpers::Calculators::PaymentCalculator.new
    calculator.calculate(course: course, content_options_ids: content_options_ids, terms: terms)
  end
end
