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

  def draw(trump_class)
    # trump_mark = trump_class.marks.sample
    trump_mark = trump_class.marks[0]
    pp trump_class.size
    if trump_mark.cards.length.positive?
      trump_class.size -= 1
      pp trump_class.size
      card = trump_mark.cards.pop
    else
      trump_class.marks = trump_class.marks.reject { |trump_mark| trump_mark.cards.empty? }
      pp trump_class.marks
      trump_class.marks
    end
  end

  # def draw(trump_marks, trump_size)
  #   # trump_mark = trump_marks.sample
  #   trump_mark = trump_marks[0]
  #   pp trump_size
  #   if trump_mark.cards.length.positive?
  #     trump_size -= 1
  #     pp trump_size
  #     card = trump_mark.cards.pop
  #   else
  #     trump_marks = trump_marks.reject { |trump_mark| trump_mark.cards.empty? }
  #   end
  # end

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
  # def define_size(trump_class)
  #   sum = 0
  #   trump_class.marks.each { |trump_mark| sum += trump_mark.cards.length }
  #   @size = sum
  # end

  def which_strong?
    ASCENDING_CARDS_STRONGNESS
  end
end

class Spade < Trump
end

class Heart < Trump
end

class Diamond < Trump
end

class Club < Trump
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

  card = prayer1.draw(trump)
  pp card
  pp trump.size
  card = prayer1.draw(trump)
  pp card
  pp trump.size
  prayer1.draw(trump)
  prayer1.draw(trump)
  prayer1.draw(trump)
  prayer1.draw(trump)
  prayer1.draw(trump)
  prayer1.draw(trump)
  prayer1.draw(trump)
  prayer1.draw(trump)
  prayer1.draw(trump)
  prayer1.draw(trump)
  prayer1.draw(trump)
  prayer1.draw(trump)
  prayer1.draw(trump)
  pp trump.marks
  pp trump.size

  # while trump.trump_size.positive?
  #   # card_this_turn = [spade, heart, diamond, club].sample
  #   prayer1.draw(trump_marks, trump.trump_size)
  #   prayer2.draw(trump_marks, trump.trump_size)
  #   # if card_this_turn.instance_of(Spade)
  #   # elsif card_this_turn.instance_of(Heart)
  #   #   prayer1.draw(Heart)
  #   #   prayer2.draw(Heart)
  #   # elsif card_this_turn.instance_of(Diamond)
  #   #   prayer1.draw(Diamond)
  #   #   prayer2.draw(Diamond)
  #   # elsif card_this_turn.instance_of(Club)
  #   #   prayer1.draw(Club)
  #   #   prayer2.draw(Club)
  #   # else
  #   #   raise
  #   # end
  # end
  # # TODO
  # # 最後にお互いの持ち札の比較
  # # プレイヤー1が勝ちました。
  # puts '戦争を終了します。'
end

war_game
