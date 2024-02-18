# frozen_string_literal: true

spade_array = (1..13).to_a
heart_array = (1..13).to_a
diamond_array = (1..13).to_a
club_array = (1..13).to_a
WAR_START_ANNOUNCEMETS = ['戦争を開始します。', 'カードが配られました。'].map(&:freeze).freeze
NOTICE_BEFORE_WAR = '戦争！'
def war_start
  [WAR_START_ANNOUNCEMETS[0], WAR_START_ANNOUNCEMETS[1], NOTICE_BEFORE_WAR].join("\n")
end

def war_game
  puts war_start
  # puts WAR_START_ANNOUNCEMETS[1]
  # puts NOTICE_BEFORE_WAR
end

war_game
