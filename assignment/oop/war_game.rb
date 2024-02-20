# frozen_string_literal: true

WAR_START_ANNOUNCEMETS = ['戦争を開始します。', 'カードが配られました。'].map(&:freeze).freeze
EVERY_TURN_NOTICE = '戦争！'
PLAYER_NUM = 2

class Player
  # プレイヤーは手札をもっていて、手札の中からカードを選び捨てて行く
  # 買った場合はカードを取得
  attr_accessor :cards_you_get

  def initialize
    @cards_you_get = 0
  end

  def draw(trump)
    trump_mark = trump.marks.sample
    if trump_mark.cards.length.positive?
      trump.size -= 1
      value = trump_mark.cards.pop
      { trump_mark_name: trump_mark.name, value: value }
    else
      trump.marks = trump.marks.reject { |trump_mark| trump_mark.cards.empty? }
      nil
    end
  end

  def get_cards(cards)
    @cards_you_get += cards
  end
end

# class GameSetting
# end

class Trump
  # 親クラスとなり、4種のカードへ継承させる
  CARDS_IN_EACH_MARK = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].map(&:to_s)
  ASCENDING_CARDS_STRONGNESS = CARDS_IN_EACH_MARK.clone

  attr_accessor :cards, :size, :marks
  attr_reader :name

  def initialize
    @cards = shuffle if self.class != Trump
  end

  def shuffle
    card_num = CARDS_IN_EACH_MARK.clone
    card_num.shuffle!
  end

  def define_marks
    @marks = ObjectSpace.each_object(Trump).select { |klass| klass.is_a?(Trump) && (klass.class != (Trump)) }
  end

  def define_size(trump_marks)
    sum = 0
    trump_marks.each { |trump_mark| sum += trump_mark.cards.length }
    @size = sum
  end

  def which_strong?(card1, card2)
    puts "プレイヤー1のカードは#{card1[:trump_mark_name]}の#{card1[:value]}です。"
    puts "プレイヤー2のカードは#{card2[:trump_mark_name]}の#{card2[:value]}です。"

    # nil unless ASCENDING_CARDS_STRONGNESS.index(card1) > ASCENDING_CARDS_STRONGNESS.index(card2)
  end
end

class Spade < Trump
  def initialize
    super
    @name = 'スペード'
  end
end

class Heart < Trump
  def initialize
    super
    @name = 'ハート'
  end
end

class Diamond < Trump
  def initialize
    super
    @name = 'ダイアモンド'
  end
end

class Club < Trump
  def initialize
    super
    @name = 'クラブ'
  end
end

def war_start
  [WAR_START_ANNOUNCEMETS[0], WAR_START_ANNOUNCEMETS[1], EVERY_TURN_NOTICE].join("\n")
end

def war_game
  puts war_start
  trump = Trump.new
  spade = Spade.new
  heart = Heart.new
  diamond = Diamond.new
  club = Club.new

  prayer1 = Player.new
  prayer2 = Player.new

  trump.define_marks
  trump.define_size(trump.marks)
  pp trump.size
  card = ''

  loop do
    prayer1_card = prayer1.draw(trump)
    prayer2_card = prayer2.draw(trump)

    if prayer1_card && prayer2_card
      trump.which_strong?(prayer1_card, prayer2_card)
    else
      puts 'プレイヤー1が勝ちました。'
      puts '戦争を終了します。'
      break
    end
  end
end

war_game
