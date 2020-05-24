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
    return Work.where(category: work_category)
  end

end
