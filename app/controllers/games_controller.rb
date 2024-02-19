class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
    @letters = []
    10.times do
      letter = ('A'..'Z').to_a.sample
      @letters << letter
    end
  end

  def score
    grid = params[:grid].gsub(" ", "").chars
    input = params[:word].downcase
    url = "https://wagon-dictionary.herokuapp.com/#{input}"
    json_file = JSON.parse(URI.open(url).read)

    new_array = [].join
    input.upcase.chars.each do |letter|
      grid.include?(letter) ? new_array << letter.downcase : false
    end

    if json_file["found"] && (new_array == input)
      @result = "Congralations, '#{input.capitalize}' is a valid word"
    elsif json_file["found"] && (new_array != input)
      @result = "Sorry, but '#{input}' can't be built out of #{grid.join(" - ")}"
    else
      @result = "Sorry, but #{input} does not seem to be a valid english word"
    end
  end
end
