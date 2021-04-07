FactoryBot.define do
  factory :user01, class: User do
    name { "一般ユーザー01" }
    email { "user01@example.jp" }
    password { "pass1234" }
    admin { false }
  end

  factory :admin01, class: User do
    name { "管理者01" }
    email { "admin01@example.jp" }
    password { "pass1234" }
    admin { true }
  end

  factory :user02, class: User do
    name { "一般ユーザー02" }
    email { "user02@example.jp" }
    password { "pass1234" }
    admin { false }
  end

  factory :user03, class: User do
    name { "一般ユーザー03" }
    email { "user03@example.jp" }
    password { "pass1234" }
    admin { false }
  end
end
