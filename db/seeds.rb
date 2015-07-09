# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do
  User.create(user_name: Faker::Internet.user_name)
end

10.times do
  Poll.create(author_id: rand(10)+1, title: Faker::Hacker.noun)
end

10.times do
  Question.create(poll_id: rand(10)+1, question: Faker::Company.catch_phrase)
end

10.times do |question_id|
  3.times do
    AnswerChoice.create(
      question_id: question_id+1,
      choice: Faker::Hacker.say_something_smart
    )
  end
end

10.times do |user_id|
  Response.create(
    user_id: user_id + 1,
    answer_choice_id: rand(30) + 1
  )
end
