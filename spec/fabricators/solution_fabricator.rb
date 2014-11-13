Fabricator(:solution) do 
  solution {Faker::Lorem.paragraph(3)}
  explanation {Faker::Lorem.paragraph(4)}
  related_links {Faker::Lorem.paragraph(2)}
end