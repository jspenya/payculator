class Moola < Money
  def self.parse_currency(amount, currency = default_currency, options = {})
    amount = amount.gsub(/[^\d.]/, '').to_f unless Numeric === amount

    currency = Currency.wrap(currency) || Money.default_currency
    value = amount.to_d * currency.subunit_to_unit
    new(value, currency, options)
  end
end
