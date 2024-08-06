require_relative 'finder/base_finder'
require_relative 'finder/course_finder'

module Helpers
  module Finder
    DEFAULT_FINDER = BaseFinder
    FINDER_KLASSES = {
      'courses' => CourseFinder,
    }.freeze

    def self.for(klass_name, data)
      (FINDER_KLASSES[klass_name] || DEFAULT_FINDER).new(data)
    end
  end
end
