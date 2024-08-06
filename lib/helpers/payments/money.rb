module Money
  def self.parse_currency(amount)
    amount.gsub(/[^\d.]/, '').to_f * 100
  end

  def self.format(amount_in_cents)
    "£%.2f" % (amount_in_cents / 100.0)
  end

  def self.to_cents(amount)
    amount.gsub(/[^\d.]/, '').to_f * 100
  end
end
