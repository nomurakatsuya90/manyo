# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "最初の管理者",
              email: "admin01@example.jp",
              password:  "pass1234",
              password_confirmation: "pass1234",
              admin: true)

10.times do |n|
  User.create!(
      email: "test#{n + 1}@gmail.com",
      name: "テストユーザ#{n + 1}",
      password: "pass1234",
      password_confirmation: "pass1234",
      admin: false
  )
end

10.times do |n|
  Task.create!(
      title: "test#{n + 1}",
      content: "タスクの内容#{n + 1}",
      expired_at: "2022-09-05 01:02:03",
      status: '未着手',
      priority: 2,
      user_id: User.first.id + n
  )
end

10.times do |n|
  Label.create!(
      name: "ラベル#{n + 1}"
  )
end
