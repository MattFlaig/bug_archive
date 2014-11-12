Fabricator(:bug) do
  name { Faker::Name.name }
  description { Faker::Lorem.paragraph(3) }
  message { Faker::Lorem.words(7).join("") }
  environment 'Test'
end