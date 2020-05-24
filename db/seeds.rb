require "csv"


CSV.foreach("db/works-seeds.csv", headers: true, header_converters: :symbol) do |row|
  Work.create(
    title: row[:title],
    category: row[:category], 
    creator: row[:creator],
    published: row[:publication_year],
    description: row[:description]
  )
end

# category,title,creator,publication_year,description
# (:title, :category, :creator, :published, :description)