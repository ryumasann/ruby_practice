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
          player.stock.push(trump.cards.pop)
        end
      end
    end
  end
end

def who_winner?(card_strongness, displayed_cards)
  displayed_card_strongness = []
  displayed_cards.each_with_index do |displayed_card, _|
    displayed_card_strongness.push(card_strongness.index(displayed_card[:value]))
  end

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
  players_displayed_cards = []
  catch :game_set do
    loop do
      battle_cards = []
      puts '戦争！'

      players.each do |player|
        if player.stock.empty?
          if !player.obtained_cards.empty?
            player.stock = player.obtained_cards.shuffle
            player.obtained_cards = []
          elsif player.obtained_cards.empty?
            puts "#{player.name}の手札がなくなりました。"
            players_displayed_cards = []
            throw :game_set
          else
            raise
          end
        end
        player.draw_card = player.stock.pop
        player.displayed_cards.push(player.draw_card)
        players_displayed_cards.push(player.draw_card)
        battle_cards.push(player.draw_card)
        puts "#{player.name}のカードは#{player.draw_card[:mark]}の#{player.draw_card[:value]}です。"
      end

      winner = who_winner?(trump.card_strongness, battle_cards)
      if winner
        puts "#{players[winner].name}が勝ちました。"
        if players_displayed_cards.length > players.length
          puts "#{players[winner].name}はカードを#{players_displayed_cards.length}枚もらいました"
        end
        players[winner].obtained_cards += players_displayed_cards
        players_displayed_cards = []
        players.each { |player| player.displayed_cards = [] }
      else
        puts '引き分けです'
      end
    end
  end

  score_message = ''
  result_message = ''
  players_score = []

  players.each do |player|
    card_sum = player.obtained_cards.length + player.stock.length + player.displayed_cards.length
    players_score.push(player_name: player.name, card_num: card_sum)
    score_message += "#{player.name}の手札の枚数は#{card_sum}枚です。"
  end

  runk_sorted_by_score = players_score.sort_by do |player|
    player[:card_num]
  end.reverse

  runk_sorted_by_score.each.with_index(1) do |rank, index|
    result_message += if index == players.length
                        "#{rank[:player_name]}が#{index}位です。"
                      else
                        "#{rank[:player_name]}が#{index}位、"
                      end
  end

  puts score_message
  puts result_message
end

war_game
