# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.destroy_all
Answer.destroy_all
Question.destroy_all

Category.create([
  {name: 'Science'},
  {name: 'Music'},
  {name: 'Arts'},
  {name: 'Memes'},
  {name: 'Literature'},
  {name: 'Programming'}
])


100.times do
  Question.create title: Faker::Hacker.say_something_smart,
                  body:  Faker::Hipster.paragraph,
                  view_count: rand(1000)
end

questions = Question.all

questions.each do |q|
  rand(1..10).times do
    Answer.create(body: Faker::RickAndMorty.quote, question: q)
  end
end

puts Cowsay.say 'Created 200 questions', :cow
puts Cowsay.say "Created #{Answer.all.count} answers! 🎩", :ghostbusters
