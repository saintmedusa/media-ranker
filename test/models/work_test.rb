require "test_helper"

describe Work do
  before do 
    @work = Work.new(title: "a", category: "album", creator: "a", published: "1209")
  end
  it "must have assigned fields" do 
    expect(@work.title).must_equal "a"
    expect(@work.creator).must_equal "a"
    expect(@work.category).must_equal "album"
    expect(@work.published).must_equal "1209"
  end

  it "must be valid" do 
    result = @work.valid?
    expect(result).must_equal true
  end

  describe "presence validation" do
    it "is invalid if title is missing" do
      @work.title = nil
      result = @work.valid?
      expect(result).must_equal false
    end
    it "is invalid if creator is missing" do
      @work.creator = nil
      result = @work.valid?
      expect(result).must_equal false
    end
    it "is invalid if published is missing" do
      @work.published = nil
      result = @work.valid?
      expect(result).must_equal false
    end
    it "is invalid if category is missing" do
      @work.category = nil
      result = @work.valid?
      expect(result).must_equal false
    end
  end
  describe "category validation" do
    Work.categories.each do |valid_category|
      work = Work.new(title: "a", category: valid_category, creator: "a", published: "1209")
      it "is valid with all expected categories" do
        expect(work.valid?).must_equal true
      end
    end
    it "invalid category" do
      work = Work.new(title: "a", category: "blah", creator: "a", published: "1209")
      expect(work.valid?).must_equal false
    end
  end

  describe "retrieve categories" do
    
    it "retrieves albums" do
      all_albums = Work.retrieve_category("album")
      all_albums.each do |album|
        expect(album.category).must_equal "album"
      end
    end
    it "retrieves books" do
      all_books = Work.retrieve_category("book")
      all_books.each do |book|
        expect(book.category).must_equal "book"
      end
    end
    it "retrieves movies" do
      all_movies = Work.retrieve_category("movie")
      all_movies.each do |movie|
        expect(movie.category).must_equal "movie"
      end
    end
  end
end
