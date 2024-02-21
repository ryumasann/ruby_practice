# frozen_string_literal: true

WAR_START_ANNOUNCEMETS = ['戦争を開始します。', 'カードが配られました。'].map(&:freeze).freeze
EVERY_TURN_NOTICE = '戦争！'
PLAYER_NUM = 2

class Player
  # プレイヤーは手札をもっていて、手札の中からカードを選び捨てて行く
  # 買った場合はカードを取得
  attr_accessor :cards_you_get
  attr_reader :draw_card

  def initialize
    @cards_you_get = 0
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

      trump.size -= 1
      value = trump_mark.cards.pop
      @draw_card = { trump_mark_name: trump_mark.name, value: value }
      break
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
  CARD_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].map(&:to_s)
  # 強さは昇順
  CARD_STRONGNESS = CARD_VALUES.clone

  attr_accessor :cards, :size, :marks
  attr_reader :name

  def initialize
    @cards = shuffle if self.class != Trump
  end

  def shuffle
    card_num = CARD_VALUES.clone
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

  def which_strong?(prayer1, prayer2)
    puts "プレイヤー1のカードは#{prayer1.draw_card[:trump_mark_name]}の#{prayer1.draw_card[:value]}です。"
    puts "プレイヤー2のカードは#{prayer2.draw_card[:trump_mark_name]}の#{prayer2.draw_card[:value]}です。"
    result = ''
    if CARD_STRONGNESS.index(prayer1.draw_card[:value]) > CARD_STRONGNESS.index(prayer2.draw_card[:value])
      puts 'プレイヤー1が勝ちました。'
      result = 'prayer1'
    elsif CARD_STRONGNESS.index(prayer1.draw_card[:value]) < CARD_STRONGNESS.index(prayer2.draw_card[:value])
      puts 'プレイヤー2が勝ちました。'
      result = 'prayer2'
    elsif CARD_STRONGNESS.index(prayer1.draw_card[:value]) == CARD_STRONGNESS.index(prayer2.draw_card[:value])
      puts '引き分けです'
      result = 'draw'
    else
      raise
    end

    # nil unless CARD_STRONGNESS.index(card1) > CARD_STRONGNESS.index(card2)
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
  [WAR_START_ANNOUNCEMETS[0], WAR_START_ANNOUNCEMETS[1]].join("\n")
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

  cards_on_table = PLAYER_NUM
  loop do
    prayer1.draw(trump)
    prayer2.draw(trump)
    if prayer1.draw_card && prayer2.draw_card
      puts EVERY_TURN_NOTICE
      case trump.which_strong?(prayer1, prayer2)
      when 'prayer1'
        prayer1.get_cards(cards_on_table)
        puts "prayer1:#{prayer1.cards_you_get}"
        cards_on_table = PLAYER_NUM unless cards_on_table == PLAYER_NUM
      when 'prayer2'
        prayer2.get_cards(cards_on_table)
        puts "prayer2:#{prayer2.cards_you_get}"
        cards_on_table = PLAYER_NUM unless cards_on_table == PLAYER_NUM
      when 'draw'
        cards_on_table += PLAYER_NUM
        next
      else
        raise
      end
    else
      puts '戦争を終了します。'
      break
    end
  end
end

war_game
