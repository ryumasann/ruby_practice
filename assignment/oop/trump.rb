# frozen_string_literal: true

class Trump
  CARD_MARKS = { spade: 'スペード', heart: 'ハート', diamond: 'ダイアモンド', club: 'クラブ' }.freeze
  CARD_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].map(&:to_s)
  # 強さは昇順
  CARD_STRONGNESS = CARD_VALUES.clone

  attr_accessor :cards, :size, :marks
  attr_reader :name, :card_strongness

  def initialize
    @cards = shuffle
    @size = cards.size
    @card_strongness = CARD_STRONGNESS
  end

  def shuffle
    cards = []
    card_values = CARD_VALUES.clone
    card_marks = CARD_MARKS.clone
    card_marks.each_value do |mark|
      card_values.each do |value|
        cards.push({ mark: mark, value: value })
      end
    end
    cards.shuffle
  end
end
