require 'byebug'
require 'json'

class MonthlyPaymentsCalculator
  VAT = '20'.freeze
  def initialize(data:)
    @data = JSON.parse(File.read(data))
  end

  attr_reader :data

  def monthly_payments(course_id:, content_options_ids:, terms:)
    errors = []

    # find_course_by_course_id
    course = data['courses'].find { |d| d['id'] == course_id }

    if content_options_ids.count > course['content_options'].count
      errors << 'Invalid number of "content_options_ids"'
      return errors
    end

    unless course['payment_terms'].find { |payment_term| payment_term['term'] == terms }
      errors << 'Invalid number of "terms"'
      return errors
    end

    # base cost
    base_cost = course['base_cost'].gsub(/[^\d.]/, '').to_f * 100

    # sum of course content options
    # sum_of_options = course['content_options'].map { |co|
    #   co['options'].find { |o|
    #     content_options_ids.include?(o['id'])
    #   }
    # }.sum { |h| h['price'].gsub(/[^\d.]/, '').to_f * 100 }
    #
    # opts = course['content_options'].flat_map { |content| content['options'] }
    #                                             .select do |option|
    #                                               if content_options_ids.include?(option['id'])
    #                                                 true
    #                                               else
    #                                                 byebug
    #                                                 errors << "Missing id for '#{option['type']}'"
    #                                               end
    #                                             end

    # fix me
    # if opts.count { |c| c['selected'] == 'true' } > 1
    #   errors << 'Only one content option is selectable'
    # end

    content_options = []
    sum_of_options = course['content_options'].reduce(0) do |sum, content|
      # Select options with 'selected' true
      # selected_options = content['options'].select { |option| option['selected'] == 'true' }

      selected_options = content['options'].select { |option| content_options_ids.include?(option['id']) }
      unless selected_options.any?
        errors << "Missing id for \"#{content['type']}\""
      end
      content_options << selected_options

      # Raise error if more than one option is selected
      # if selected_options.size > 1
      #   errors << 'Only one content option is selectable per content type'
      # end

      content_options.flatten!

      if content_options.count { |x| x['selected'] == 'true' } > 1
        errors << 'Only one content option is selectable'
        next
      end

      # byebug
      # Sum the prices of the selected options with specific IDs
      selected_options.each do |option|
        price = option['price'].gsub(/[^\d.]/, '').to_f * 100
        sum += price
      end

      sum
    end

    return errors if errors.any?

    # discounted value
    discounted_value = course['payment_terms'].find { |term| term['term'] == terms }.dig('discounted_value').to_f

    base_and_options_cost = base_cost + sum_of_options
    result = ( ( base_and_options_cost ) - ( discounted_value * ( base_and_options_cost ) ) + (VAT.to_f/100) ) / terms
    dollars = result / 100.0
    formatted_money = "£%.2f" % dollars
    formatted_money
  end
end
