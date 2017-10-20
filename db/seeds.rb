# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
100.times do |t|
  ## Users
  if t==0
    email="ksk55jp@gmail.com"
    name="啓介さん"
  else
    email=Faker::Internet.email
    name=Faker::Name.name
  end
  password="password"
#  User.create!(email: email,
#     password: password,
#     password_confirmation: password,
#     name: name
#  )
  ## Topics
#  Topic.create!(
#    user_id: t+1,
#    title: Faker::DragonBall.character,
#    content: Faker::Matz.quote
#  )
end
