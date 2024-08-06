require 'spec_helper'
require 'monthly_payments_calculator'

RSpec.describe MonthlyPaymentsCalculator do
  let(:json_file_path) { './courses.json' }
  let(:calculator) { MonthlyPaymentsCalculator.new(data: json_file_path) }

  describe '#monthly_payments' do
    context 'with valid monthly payments' do
      it 'calculates the correct monthly payment for 12 months term' do
        result = calculator.monthly_payments(course_id: "001", content_options_ids: [10, 19], terms: 12)
        expect(result).to eq('£38.33')
      end

      it 'calculates the correct monthly payment for 6 months term' do
        result = calculator.monthly_payments(course_id: "002", content_options_ids: [54, 15, 182], terms: 6)
        expect(result).to eq('£257.32')
      end
    end

    context 'with invalid arguments' do
      it 'returns an error when multiple content options are selected' do
        result = calculator.monthly_payments(course_id: "001", content_options_ids: [19, 11], terms: 12)
        expect(result).to eq(['Only one content option is selectable'])
      end

      it 'returns an error when no content options are selected' do
        result = calculator.monthly_payments(course_id: "001", content_options_ids: [], terms: 12)
        expect(result).to eq(['Missing id for "standard_content"', 'Missing id for "pro_content"'])
      end

      it 'returns an error for invalid content options count' do
        result = calculator.monthly_payments(course_id: "001", content_options_ids: [10, 19, 182], terms: 12)
        expect(result).to eq(['Invalid number of "content_options_ids"'])
      end

      it 'returns an error for invalid terms' do
        result = calculator.monthly_payments(course_id: "001", content_options_ids: [10, 19], terms: 24)
        expect(result).to eq(['Invalid number of "terms"'])
      end
    end
  end
end
