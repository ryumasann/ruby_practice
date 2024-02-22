# frozen_string_literal: true

require_relative 'trump'
require_relative 'player'
WAR_START_ANNOUNCEMETS = ['戦争を開始します。', 'カードが配られました。'].map(&:freeze).freeze
EVERY_TURN_NOTICE = '戦争！'
PLAYER_NUM = 2

# class GameSetting
#   CARD_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].map(&:to_s)
#   attr_reader :CARD_VALUES

#   def initialize
#     @card_values = CARD_VALUES
#   end

#   def distribute
#     @card_values = CARD_VALUES
#   end
# end

def distribute
  @card_values = CARD_VALUES
end

def war_game
  puts '戦争を開始します。'
  trump = Trump.new
  players = []
  (1..PLAYER_NUM).each { |i| players.push(Player.new(i)) }

  trump.distribute(players)

  puts 'カードが配られました。'
  puts '戦争！'
  players.each do |player|
    player.draw_cards.pop
    puts "#{player.name}のカードは#{player.draw_card[:trump_mark_name]}の#{prayer1.draw_card[:value]}です。"
  end
  this_turn_player.draw_cards.pop

  # loop do

  #   players[0].draw(trump)
  #   players[1].draw(trump)
  #   if players[0].draw_card && players[1].draw_card
  #     case trump.which_strong?(players[0], players[1])
  #     when "#{players[0].name}"
  #       players[0].get_cards(cards_on_table)
  #       puts "#{players[0].name}:#{players[0].cards_you_get}"
  #       cards_on_table = PLAYER_NUM unless cards_on_table == PLAYER_NUM
  #     when "#{players[1].name}"
  #       players[1].get_cards(cards_on_table)
  #       puts "#{players[1].name}:#{players[1].cards_you_get}"
  #       cards_on_table = PLAYER_NUM unless cards_on_table == PLAYER_NUM
  #     when 'draw'
  #       cards_on_table += PLAYER_NUM
  #       next
  #     else
  #       raise
  #     end
  #   else
  #     puts '戦争を終了します。'
  #     break
  #   end
  # end
  # players.each do |player|
  #   if player.have_card?
end

war_game
