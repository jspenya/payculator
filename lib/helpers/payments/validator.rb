module Helpers
  module Payments
    class Validator
      def initialize(course:, content_options_ids:, terms:)
        @course = course
        @content_options_ids = content_options_ids
        @terms = terms
        @errors = []
      end

      attr_accessor :course, :content_options_ids, :terms, :errors

      def validate
        validate_content_options
        validate_terms
        validate_single_content_selection

        errors
      end

      private

      def validate_content_options
        if content_options_ids.count > course.content_options.count
          errors << 'Invalid number of "content_options_ids"'
        end

        course.content_options.each do |content_option|
          selected_options = content_option.options.select { |option| content_options_ids.include?(option.id) }
          unless selected_options.any?
            errors << "Missing id for \"#{content_option.type}\""
          end
        end
      end

      def validate_terms
        unless course.find_payment_term(terms)
          errors << 'Invalid number of "terms"'
        end
      end

      def validate_single_content_selection
        selected_options = course.content_options.flat_map(&:options).select { |option| content_options_ids.include?(option.id) }
        if selected_options.count { |x| x.selected == 'true' } > 1
          errors << 'Only one content option is selectable'
        end
      end
    end
  end
end
