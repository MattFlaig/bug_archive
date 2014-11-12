Fabricator(:user) do 
  email { Faker::Internet.email }
  name { Faker::Name.name }
  password 'hello'
end