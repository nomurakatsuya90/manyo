FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    created_at { '2021-03-26 17:00' }
    expired_at { '2021-04-01 10:26' }
    status { '未着手' }
  end
end
