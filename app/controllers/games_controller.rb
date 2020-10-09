require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = ""
    10.times { @letters << alphabet.sample }
  end

  def score
    @word = params[:word].upcase
    @grid = params[:grid]

    # checar se a palavra esta na grade gerada
    # valid = (@word.chars - @grid.chars).empty? # => sem se importar com chars repetidos

    # verifica se cada letra da palavra aparece menos vezes na palavra do que na grade
    valid_in_grid = @word.chars.all? { |letter| @word.count(letter) <= @grid.count(letter) }

    # fazer a requisicao para a url
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    response = open(url).read

    # fazer o Parse
    parsed = JSON.parse(response)

    # checar se a palavra existe no dicionario
    valid_in_dict = parsed["found"]

    # calcular a pontuacao
    if valid_in_dict && valid_in_grid
      @score = @word.size * 100
    else
      @score = 0
    end
  end
end
