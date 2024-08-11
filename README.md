Monthly Payments Calculator
===========================
```
$ irb -I lib -r your_library.rb
>> calculator = MonthlyPaymentsCalculator.new(data: "./courses.json")
```

### Assertions

```rb
calculator = MonthlyPaymentsCalculator.new(data: "./courses.json")

# Calculations
calculator.monthly_payments(course_id: "001", content_options_ids: [10, 19], terms: 12) # => £xxx.xx
calculator.monthly_payments(course_id: "001", content_options_ids: [11, 20], terms: 1) # => £xxx.xx

calculator.monthly_payments(course_id: "002", content_options_ids: [54, 15, 182], terms: 6) # => £xxx.xx
calculator.monthly_payments(course_id: "002", content_options_ids: [54, 172, 78], terms: 12) # => £xxx.xx

# Invalid arguments:
calculator.monthly_payments(course_id: "001", content_options_ids: [19, 11], terms: 12)
  # => ['Only one content option is selectable']

calculator.monthly_payments(course_id: "001", content_options_ids: [], terms: 12)
  # => ['Missing id for "standard_content"', 'Missing id for "pro_content"']

calculator.monthly_payments(course_id: "001", content_options_ids: [10, 19, 182], terms: 12)
  # => ['Invalid number of "content_options_ids"']

calculator.monthly_payments(course_id: "001", content_options_ids: [10, 19], terms: 24)
  # => ['Invalid number of "terms"']
```