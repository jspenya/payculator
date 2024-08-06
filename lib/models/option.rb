class Option
  def initialize(option_data)
    @id = option_data['id']
    @price = option_data['price']
    @selected = option_data['selected']
  end

  attr_reader :id, :price, :selected
end
