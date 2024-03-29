# frozen_string_literal: true

class Trump
  CARD_MARKS = { spade: 'スペード', heart: 'ハート', diamond: 'ダイアモンド', club: 'クラブ' }.freeze
  CARD_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].map(&:to_s)
  # 強さは昇順
  CARD_STRONGNESS = CARD_VALUES.clone

  attr_accessor :cards
  attr_reader :card_strongness

  def initialize
    @cards = make_cards
    @card_strongness = CARD_STRONGNESS
  end

  def make_cards
    card_list = []
    card_values = CARD_VALUES
    card_marks = CARD_MARKS
    card_marks.each_value do |mark|
      card_values.each do |value|
        card_list.push({ mark: mark, value: value })
      end
    end
    card_list.shuffle
  end
end
