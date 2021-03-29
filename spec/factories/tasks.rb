FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    created_at { '2021-03-26 17:00' }
  end
end
