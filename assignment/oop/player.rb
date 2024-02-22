# frozen_string_literal: true

class Player
  # プレイヤーは手札をもっていて、手札の中からカードを選び捨てて行く
  # 買った場合はカードを取得
  attr_accessor :cards_you_get, :distributed_cards
  attr_reader :draw_card, :name

  def initialize(num)
    @cards_you_get = 0
    @distributed_cards = []
    @draw_card = nil
    @name = "プレイヤー#{num}"
  end

  def draw(trump)
    loop do
      if trump.marks.empty?
        @draw_card = nil
        break
      end

      trump_mark = trump.marks.sample
      if trump_mark.cards.empty?
        trump.marks = trump.marks.reject { |trump_mark| trump_mark.cards.empty? }
        next
      end

      # trump.size -= 1
      value = trump_mark.cards.pop
      @draw_card = { trump_mark_name: trump_mark.name, value: value }
      break
    end
  end

  def get_cards(cards)
    @cards_you_get += cards
  end

  # def get_cards(cards)
  #   @distributed_cards += cards
  # end
end

# class GameSetting
# end
