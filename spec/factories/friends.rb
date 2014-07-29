# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :friend do
    name "MyString"
    birthday "2014-07-29 14:25:32"
    user nil
  end
end
