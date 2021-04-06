FactoryBot.define do
  factory :user01 do
    name { "一般ユーザー01" }
    sequence(:email) { "user01@example.jp" }
    password { "pass1234" }
    admin { false }
  end

  factory :admin01, class: User do
    name { "管理者01" }
    sequence(:email) { "admin01@example.jp" }
    password { "pass1234" }
    admin { true }
  end
end
