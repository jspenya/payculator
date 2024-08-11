class Calculator
  SEQUENCE = [
    'OptionsCostCalculator',
    'DiscountCalculator',
    'VATCalculator',
    'TotalCostCalculator',
  ]

  def calculate; end

  def parse_cents(amount)
    Moola.parse_currency(amount).cents
  end
end
