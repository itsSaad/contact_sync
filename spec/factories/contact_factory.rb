FactoryGirl.define do
  factory :contact do
    first_name "John"
    middle_name "Hans"
    last_name  "Doe"
    composite_name "John Doe"
    prefix ""
    suffix ""
    nickname "Joe"
    organization "QBXNet"
    job_title "Software Engineer"
    birthdate DateTime.now - 20.years
    record_id 12
    creation_date DateTime.now - 1.month
    modification_date DateTime.now - 2.days

  end
end
