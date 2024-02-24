# frozen_string_literal: true

class Player
  # プレイヤーは手札をもっていて、手札の中からカードを選び捨てて行く
  # 買った場合はカードを取得
  attr_accessor :draw_card, :stock, :obtained_cards, :displayed_cards
  attr_reader :name

  def initialize(num)
    @draw_card = {}
    @stock = []
    @name = "プレイヤー#{num}"
    @obtained_cards = []
    @displayed_cards = []
  end
end
