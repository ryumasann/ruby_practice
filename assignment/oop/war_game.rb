# frozen_string_literal: true

require_relative 'trump'
require_relative 'player'

def retrive_player_num
  player_num = 0
  loop do
    print 'プレイヤーの人数を入力してください（2〜5）: '
    player_num = gets.chomp.to_i
    break if (2..5).include?(player_num)

    puts 'プレイヤーの人数は2～5で入力してください。'
  end
  player_num
end

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
  displayed_cards.each do |displayed_card|
    displayed_card_strongness.push(card_strongness.index(displayed_card[:value]))
  end

  return false if displayed_card_strongness.count(displayed_card_strongness.max) >= 2

  displayed_card_strongness.index(displayed_card_strongness.max)
end

def war_game
  puts '戦争を開始します。'
  trump = Trump.new

  # 人数分のplayerインスタンス作成
  players = []
  (1..retrive_player_num).each do |i|
    puts "プレイヤー#{i}の名前を入力してください: "
    name = gets.chomp.to_s.force_encoding('UTF-8')
    if name.empty?
      puts '空白のため、以下デフォルトの名前を用意いたします。'
      puts "プレイヤー#{i}"
      default_name = "プレイヤー#{i}"
      players.push(Player.new(default_name))
      next
    else
      players.push(Player.new(name))
    end
  end

  distribute(trump, players)
  puts 'カードが配られました。'

  ######### gameのメイン処理 #########
  # 処理が長いので関数に分割したい
  players_displayed_cards = []
  catch :game_set do
    loop do
      battle_cards = []
      puts '戦争！'

      # 各プレイヤーのドロー処理と試合終了の判定
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

      # 試合結果判定
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

  ######### スコア集計と試合結果出力 #########
  score_message = ''
  result_message = ''
  players_score = []

  # スコア集計メッセージ作成
  players.each do |player|
    card_sum = player.obtained_cards.length + player.stock.length + player.displayed_cards.length
    players_score.push(name: player.name, card_num: card_sum)
    score_message += "#{player.name}の手札の枚数は#{card_sum}枚です。"
  end

  # 昇順での順位作成と同率順位の場合の順位作成
  player_sorted_by_score = players_score.sort_by { |player| player[:card_num] }.reverse

  player_sorted_by_uniq_score = player_sorted_by_score.uniq { |player| player[:card_num] }.map.with_index(1).to_h
  runk_sorted_by_score = player_sorted_by_score.map.with_index(1) do |score, index|
    player_sorted_by_uniq_score[score] || index
  end

  # 試合結果作成
  player_sorted_by_score.each.with_index do |player, rank|
    result_message += if player_sorted_by_score.length == rank + 1
                        "#{player[:name]}が#{runk_sorted_by_score[rank]}位です。"
                      else
                        "#{player[:name]}が#{runk_sorted_by_score[rank]}位、"
                      end
  end

  puts score_message
  puts result_message
end

war_game
