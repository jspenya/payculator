class PaymentTerm
  def initialize(term_data)
    @term = term_data['term']
    @discounted_value = term_data['discounted_value'].to_f
  end

  attr_reader :term, :discounted_value
end
