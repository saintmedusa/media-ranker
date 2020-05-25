require "test_helper"

describe User do
  it "creates valid user" do
    user = User.new(username: "name")
    expect(user.valid?).must_equal true
  end
  it "rejects nil username" do
    user = User.new(username: "")
    expect(user.valid?).must_equal false
  end
  it "rejects duplicate user" do
    user1 = User.new(username: "sarah")
    user2 = User.new(username: "sarah")
    expect(user2.valid?).must_equal false
  end
  it "returns joined date" do
  end
end
