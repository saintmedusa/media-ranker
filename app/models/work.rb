class Work < ApplicationRecord
  @categories = ["book", "album", "movie"]
  validates :title, presence: true
  validates :category, presence: true, inclusion: {in: @categories}
  validates :creator, presence: true
  validates :published, presence: true
    #numericality: {only_integer: true, less_than_or_equal_to: Time.now.year}

  
  def self.categories
    return @categories
  end
  
  def self.retrieve_category(work_category)
    if !@categories.include? work_category
      raise ArgumentError.new("not a valid category")
    end
    return Work.where(category: work_category).to_a
  end

  def self.category_hash
    works = {}
    Work.categories.each do |category|
      works[category] = Work.retrieve_category(category)
    end
    return works
  end

  def self.top_10(works)
    return works.sample(10)
  end

end
