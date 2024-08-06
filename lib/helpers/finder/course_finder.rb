module Helpers
  module Finder
    class CourseFinder < BaseFinder
      def find_by_id(course_id)
        course_data = find_by(:id, course_id)
        course_data ? Course.new(course_data) : nil
      end
    end
  end
end
