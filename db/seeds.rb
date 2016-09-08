# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


80.times do |n|
  org_name = Faker::Name.name
  email = "example@railstutorial.org"
  password = "password"
  info = "I am here"
  website_URL="example@railstutorial.org"
  contacts="here"
  logo_url="example@railstutorial.org"
  @org=Organization.create!(
              org_name: org_name,
               email: email,
               
               password:password,
               password_confirmation: password,
               info: info,
               website_URL: website_URL,
               contacts: contacts,
               logo_url: logo_url


                 )
5.times do |n|
  title  = Faker::Name.name
  description = "I am here"
  start_date="monday"
  end_date="friday"
  in_progress= false
  urgent_rate= 2
  money=1000

  @org.needs.create(title: title,
               description: description,
               start_date: start_date,
                end_date: end_date,
                in_progress: in_progress,
                money: money,
                urgent_rate: urgent_rate)

end
5.times do |n|
  title  = Faker::Name.name
  description = "I am here"
  start_date="monday"
  end_date="friday"
  in_progress= true
  urgent_rate= 2
  money=1000

  @org.needs.create(title: title,
               description: description,
               start_date: start_date,
                end_date: end_date,
                in_progress: in_progress,
                money: money,
                urgent_rate: urgent_rate)

end
end
