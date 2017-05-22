FactoryGirl.define do
  factory :answer do
    content "MyText"
    user nil
    question nil
    vote 1
  end
end
