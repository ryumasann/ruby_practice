# frozen_string_literal: true

class Trump
  CARD_MARKS = { spade: 'スペード', heart: 'ハート', diamond: 'ダイアモンド', club: 'クラブ' }.freeze
  CARD_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].map(&:to_s)
  # 強さは昇順
  CARD_STRONGNESS = CARD_VALUES.clone

  attr_accessor :cards, :size, :marks
  attr_reader :name

  def initialize
    @cards = shuffle
    @size = cards.size
  end

  def shuffle
    cards = []
    card_values = CARD_VALUES.clone
    card_marks = CARD_MARKS.clone
    card_marks.each do |_key, mark|
      card_values.each do |value|
        cards.push({ mark: mark, value: value })
      end
    end
    cards.shuffle
  end

  def distribute(players)
    catch :done do
      loop do
        players.each do |player|
          if @cards.empty?
            throw :done
          else
            player.distributed_cards.push(@cards.pop)
          end
        end
      end
    end
  end
  # def distribute
  #   @marks = ObjectSpace.each_object(Trump).select { |klass| klass.is_a?(Trump) && (klass.class != (Trump)) }
  # end

  # def define_marks
  #   @marks = ObjectSpace.each_object(Trump).select { |klass| klass.is_a?(Trump) && (klass.class != (Trump)) }
  # end

  # def define_size(trump_marks)
  #   sum = 0
  #   trump_marks.each { |trump_mark| sum += trump_mark.cards.length }
  #   @size = sum
  # end

  def who_strongest?(prayer1, prayer2)
    puts "#{prayer1.name}のカードは#{prayer1.draw_card[:trump_mark_name]}の#{prayer1.draw_card[:value]}です。"
    puts "プレイヤー2のカードは#{prayer2.draw_card[:trump_mark_name]}の#{prayer2.draw_card[:value]}です。"
    result = ''
    if CARD_STRONGNESS.index(prayer1.draw_card[:value]) > CARD_STRONGNESS.index(prayer2.draw_card[:value])
      puts "#{prayer1.name}が勝ちました。"
      result = prayer1.name
    elsif CARD_STRONGNESS.index(prayer1.draw_card[:value]) < CARD_STRONGNESS.index(prayer2.draw_card[:value])
      puts "#{prayer2.name}が勝ちました。"
      result = prayer2.name
    elsif CARD_STRONGNESS.index(prayer1.draw_card[:value]) == CARD_STRONGNESS.index(prayer2.draw_card[:value])
      puts '引き分けです'
      result = 'draw'
    else
      raise
    end
  end
end

# class Spade < Trump
#   def initialize
#     super
#     @name = 'スペード'
#   end
# end

# class Heart < Trump
#   def initialize
#     super
#     @name = 'ハート'
#   end
# end

# class Diamond < Trump
#   def initialize
#     super
#     @name = 'ダイアモンド'
#   end
# end

# class Club < Trump
#   def initialize
#     super
#     @name = 'クラブ'
#   end
# end
