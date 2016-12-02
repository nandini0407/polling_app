# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
adom = User.create!(user_name: "Adom")
nandini = User.create!(user_name: "Nandini")
steve = User.create!(user_name: "Steve")

Poll.destroy_all
adom_poll = Poll.create!(author_id: adom.id, title: "Important Poll")
nandini_poll = Poll.create!(author_id: nandini.id, title: "Apathetic Poll")
steve_poll = Poll.create!(author_id: steve.id, title: "Steve's Poll")

Question.destroy_all
adom_q1 = Question.create!(poll_id: adom_poll.id, text: "Why?")
adom_q2 = Question.create!(poll_id: adom_poll.id, text: "When?")
adom_q3 = Question.create!(poll_id: adom_poll.id, text: "How?")

nandini_q1 = Question.create!(poll_id: nandini_poll.id, text: "When will I sleep?")
nandini_q2 = Question.create!(poll_id: nandini_poll.id, text: "What should I write?")

steve_q = Question.create!(poll_id: steve_poll.id, text: "Steve's question?")

AnswerChoice.destroy_all
30.times do |i|
  AnswerChoice.create!(question_id: i % 6 + 1, text: Faker::GameOfThrones.character)
end

Response.destroy_all
100.times do |j|
  Response.create!(user_id: rand(2) + 1, answer_id: rand(30) + 1)
end
