class ContentOption
  attr_reader :type, :options

  def initialize(content_data)
    @type = content_data['type']
    @options = content_data['options'].map { |option| Option.new(option) }
  end
end
