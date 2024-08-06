module Helpers
  module Finder
    class BaseFinder
      def initialize(data)
        @data = data
      end

      attr_accessor :data

      def find_by(attribute, value)
        data.find do |item|
          item[attribute.to_s] == value || item[attribute] == value
        end
      end
    end
  end
end
