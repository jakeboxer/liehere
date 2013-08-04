# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :statement do
    text "MyString"
    user nil
    lie false
  end
end
