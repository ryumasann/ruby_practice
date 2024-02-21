# frozen_string_literal: true

require_relative 'trump'
require './player'
WAR_START_ANNOUNCEMETS = ['戦争を開始します。', 'カードが配られました。'].map(&:freeze).freeze
EVERY_TURN_NOTICE = '戦争！'
PLAYER_NUM = 2

# class GameSetting
# end

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
