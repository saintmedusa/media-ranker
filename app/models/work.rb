class Work < ApplicationRecord
  has_many :votes
  @categories = ["book", "album", "movie"]
  validates :title, presence: true
  validates :category, presence: true, inclusion: {in: @categories}
  validates :creator, presence: true
  validates :published, presence: true

  
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

  def num_votes
    return self.votes.length
  end
  
  def self.top_10(works)
    sorted_works = works.sort {|work1, work2|
      work2 <=> work1
    }
    if sorted_works.length <= 10
      return sorted_works
    else
      return sorted_works.slice(0,10)
    end
  end

  def <=>(other)
    if other.class != Work
      return nil
    elsif self.num_votes < other.num_votes
      return -1
    elsif self.num_votes > other.num_votes
      return  1
    else # self == other 
      return  0
    end
  end

end
