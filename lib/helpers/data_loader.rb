require 'json'

module Helpers
  class DataLoader
    def initialize(file_path)
      @file_path = file_path
    end

    attr_reader :file_path

    def load_data
      JSON.parse File.read(file_path)
    end
  end
end
