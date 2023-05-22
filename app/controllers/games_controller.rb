require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ("a".."z").to_a.sample(10)
  end

  def score
    @word = params["word"]
    @letters = params["letters"].split
    english = valid_english(@word)
    grid = valid_grid(@word, @letters)
    @score_message = compute_score(english, grid)
  end

  def valid_english(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)
    word["found"]
  end

  def valid_grid(word, letters)
    word.chars.all? do |letter|
      letters.count(letter) >= word.chars.count(letter)
    end
  end

  def compute_score(english, grid)
    @score = 0
    if english && grid == true
      @score += 1
      "Success!"
    else
      "WRONG BRO"
    end
  end
end
