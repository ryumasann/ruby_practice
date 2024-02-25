# frozen_string_literal: true

class Player
  attr_accessor :draw_card, :stock, :obtained_cards, :displayed_cards
  attr_reader :name

  def initialize(name)
    @draw_card = {}
    @stock = []
    @name = name
    @obtained_cards = []
    @displayed_cards = []
  end
end
