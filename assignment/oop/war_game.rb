# frozen_string_literal: true

require_relative 'trump'
require './player'
WAR_START_ANNOUNCEMETS = ['戦争を開始します。', 'カードが配られました。'].map(&:freeze).freeze
EVERY_TURN_NOTICE = '戦争！'
PLAYER_NUM = 2

class GameSetting
  CARD_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].map(&:to_s)
  attr_reader :CARD_VALUES

  def initialize
    @card_values = CARD_VALUES
  end

  def distribute
    @card_values = CARD_VALUES
  end
end

def war_game
  puts [WAR_START_ANNOUNCEMETS[0], WAR_START_ANNOUNCEMETS[1]].join("\n")
  trump = Trump.new
  spade = Spade.new
  heart = Heart.new
  diamond = Diamond.new
  club = Club.new

  players = []
  (1..PLAYER_NUM).each { |i| players.push(Player.new(i)) }

  trump.define_marks
  # trump.distribute(players)
  # trump.define_size(trump.marks)

  cards_on_table = PLAYER_NUM
  loop do
    players[0].draw(trump)
    players[1].draw(trump)
    if players[0].draw_card && players[1].draw_card
      puts EVERY_TURN_NOTICE
      case trump.which_strong?(players[0], players[1])
      when "#{players[0].name}"
        players[0].get_cards(cards_on_table)
        puts "#{players[0].name}:#{players[0].cards_you_get}"
        cards_on_table = PLAYER_NUM unless cards_on_table == PLAYER_NUM
      when "#{players[1].name}"
        players[1].get_cards(cards_on_table)
        puts "#{players[1].name}:#{players[1].cards_you_get}"
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
