FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    created_at { '2021-03-26 17:00' }
    expired_at { '2021-04-01 10:26' }
    status { '未着手' }
    # user_id { }
    association :user
  end

  # factory: :user01

#   factory :task03, class: Task do
#     title { 'task03' }
#     content { '内容03' }
#     created_at { '2021-03-26 17:03' }
#     expired_at { '2021-04-03 16:01' }
#     status { '未着手' }
#     # user { }
#     association :user, :user01
#     # association :user
#     # association :user, factory: :user01
#   end
#   factory :task01, class: Task do
#     title { 'task01' }
#     content { '内容01' }
#     created_at { '2021-03-26 17:01' }
#     expired_at { '2021-04-01 17:021' }
#     status { '着手中' }
#     user_id { 3 }
#     # association :user_id, factory: :user01
#     association :user
#     # association :user
#   end
#   factory :task02, class: Task do
#     title { 'task02' }
#     content { '内容02' }
#     created_at { '2021-03-26 17:02' }
#     expired_at { '2021-04-02 15:02' }
#     status { '完了' }
#     user_id { 3 }
#     # association :user_id, factory: :user01
#     # association :user
#     association :user
#   end
end
