require 'minitest/autorun'
require_relative '../../lib/monthly_payments_calculator.rb'
#
#
#
# Remove Me
require 'byebug'

class MonthlyPaymentsCalculatorTest < Minitest::Test
  def setup
    @json_file_path = './courses.json'
    @calculator = MonthlyPaymentsCalculator.new(data: @json_file_path)
  end

  def test_valid_monthly_payments
    # skip
    assert_equal '£31.94', @calculator.monthly_payments(course_id: "001", content_options_ids: [10, 19], terms: 12)
    assert_equal '£618.66', @calculator.monthly_payments(course_id: "001", content_options_ids: [11, 20], terms: 1)
  end

  def test_invalid_arguments
    assert_equal ['Only one content option is selectable'], @calculator.monthly_payments(course_id: "001", content_options_ids: [19, 11], terms: 12)
    assert_equal ['Missing id for "standard_content"', 'Missing id for "pro_content"'], @calculator.monthly_payments(course_id: "001", content_options_ids: [], terms: 12)
    assert_equal ['Invalid number of "content_options_ids"'], @calculator.monthly_payments(course_id: "001", content_options_ids: [10, 19, 182], terms: 12)
    assert_equal ['Invalid number of "terms"'], @calculator.monthly_payments(course_id: "001", content_options_ids: [10, 19], terms: 24)
  end
end
