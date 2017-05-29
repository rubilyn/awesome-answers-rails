User.destroy_all
Category.destroy_all
Answer.destroy_all
Question.destroy_all

PASSWORD = 'pass123'

categories = Category.create([
  {name: 'Science'},
  {name: 'Music'},
  {name: 'Arts'},
  {name: 'Memes'},
  {name: 'Literature'},
  {name: 'Programming'}
])

users = User.create([
  {first_name: 'Jon', last_name: 'Snow', email: 'js@winterfell.gov', password: PASSWORD},
  {first_name: 'Daenerys', last_name: 'Targaryan', email: 'daeny@dragon.io', password: PASSWORD},
  {first_name: 'Cersei', last_name: 'Lannister', email: 'cs@iron.throne', password: PASSWORD}
])

100.times do
  Question.create title: Faker::Hacker.say_something_smart,
                  body:  Faker::Hipster.paragraph,
                  view_count: rand(1000),
                  user: users.sample,
                  category: categories.sample
end

questions = Question.all

questions.each do |q|
  rand(1..5).times do
    Answer.create(body: Faker::RickAndMorty.quote, question: q)
  end
end

puts Cowsay.say 'Created 200 questions', :cow
puts Cowsay.say "Created #{Answer.all.count} answers! 🎩", :ghostbusters
