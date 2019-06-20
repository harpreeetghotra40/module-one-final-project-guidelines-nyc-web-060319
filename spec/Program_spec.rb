require_relative "../lib/song"

# 1.
# make sure it works :)
# make sure it doesnt work when it doesnt work

# 2.
# EDGE CASES
# ??

# 3. space complexity
#

# RED / GREEN / REFACTOR

describe "add_song" do
  it "should ADD a song to a playlist" do
    expect(add_song("All the small things")).to eq(true)
  end

#   it "should return false if the word is NOT a palindrome" do
#     expect(is_palindrome?("plant")).to eq(false)
#   end

#   it "should return true if the word or 'number' is a palindrome" do
#     expect(is_palindrome?("111")).to eq(true)
#   end

#   it "should return false if the word is empty" do
#     expect(is_palindrome?("")).to eq(false)
#   end


#   it "should return false if the word is empty" do
#     expect(is_palindrome?("a man a plan a canal panama")).to eq(true)
#   end

#   it "should return true if word is a palindrome" do
#     expect {is_palindrome?(["poop"])}.to raise_error(ArgumentError)
#   end

#   it "should raise ArgumentError if the word is NOT a string" do
#     expect {is_palindrome?(111)}.to raise_error(ArgumentError)
#   end

end