class Course
  def initialize(course_data)
    @id = course_data['id']
    @base_cost = Moola.parse_currency(course_data['base_cost']).cents
    @content_options = course_data['content_options'].map { |co| ContentOption.new(co) }
    @payment_terms = course_data['payment_terms'].map { |pt| PaymentTerm.new(pt) }
  end

  attr_reader :id, :base_cost, :content_options, :payment_terms

  def find_payment_term(term)
    payment_terms.find { |payment_term| payment_term.term == term }
  end
end
