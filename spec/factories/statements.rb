# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory(:statement, :aliases => [:truth_statement]) do
    text "MyString"
    user nil
    truth true

    factory :lie_statement do
      truth false
    end
  end
end
