# frozen_string_literal: true

require_relative 'trump'
require_relative 'player'
WAR_START_ANNOUNCEMETS = ['戦争を開始します。', 'カードが配られました。'].map(&:freeze).freeze
EVERY_TURN_NOTICE = '戦争！'
PLAYER_NUM = 2

def distribute(trump, players)
  catch :done do
    loop do
      players.each do |player|
        if trump.cards.empty?
          throw :done
        else
          player.distributed_cards.push(trump.cards.pop)
        end
      end
    end
  end
end

def who_winner?(card_strongness, displayed_cards)
  displayed_card_strongness = []
  # players = []
  displayed_cards.each_with_index do |displayed_card, _player_num|
    displayed_card_strongness.push(card_strongness.index(displayed_card[:value]))
    # players.push(player_num)
    # displayed_card_strongness.push({ player: player_num, strongness: player_draw_card_strongness })
    # displayed_card_strongness = player_draw_card_strongness
  end
  # strongness_array = displayed_card_strongness.map do |player_draw_card_strongness|
  #   player_draw_card_strongness[:strongness]
  # end.flatten

  return false unless displayed_card_strongness.uniq.length == displayed_card_strongness.length

  displayed_card_strongness.index(displayed_card_strongness.max)
end

def war_game
  puts '戦争を開始します。'
  trump = Trump.new
  players = []
  (1..PLAYER_NUM).each { |i| players.push(Player.new(i)) }

  distribute(trump, players)

  puts 'カードが配られました。'
  displayed_cards = []
  loop do
    battle_cards = []
    # is_draw = false
    puts '戦争！'

    players.each do |player|
      player.draw_cards = player.distributed_cards.pop
      displayed_cards.push(player.draw_cards)
      battle_cards.push(player.draw_cards)
      puts "#{player.name}のカードは#{player.draw_cards[:mark]}の#{player.draw_cards[:value]}です。"
    end

    winner = who_winner?(trump.card_strongness, battle_cards)
    if winner
      puts "#{players[winner].name}が勝ちました。"
      puts "#{players[winner].name}はカードを#{displayed_cards.size}もらいました" if displayed_cards.length > players.length
      players[winner].get_cards.push(displayed_cards)
      displayed_cards = []
    else
      puts '引き分けです'
    end
  end

  # this_turn_player.distributed_cards.pop

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
