require "csv"


# CSV.foreach("db/works-seeds.csv", headers: true, header_converters: :symbol) do |row|
#   Work.create(
#     title: row[:title],
#     category: row[:category], 
#     creator: row[:creator],
#     published: row[:publication_year],
#     description: row[:description]
#   )
# end

CSV.foreach("db/users_seeds.csv", headers: true, header_converters: :symbol) do |row|
  User.create(username: row[:username])
end