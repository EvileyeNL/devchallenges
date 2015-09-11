FactoryGirl.define do
  factory :codechallenge do
    name "Codechallenge"
    description  "This is text"
    background "Some more text"
    problem "def multiply(a b)\r\n  a * b\r\nend"
    solution "def multiply(a, b)\r\n  a * b\r\nend"
    test_code "multiply(4,5) == 20"
    attempts_number 100
  end
end
