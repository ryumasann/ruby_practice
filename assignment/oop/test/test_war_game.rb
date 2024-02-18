# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../war_game'
class WarGameTest < Minitest::Test
  # minitest only run function which statu from "test_".
  def test_step1
    assert_equal "戦争を開始します。\nカードが配られました。\n戦争！", war_start
    # assert_equal 'a', 'a'
    # assert_equal '日本語', 'テスト'
    # assert_equal 'a', 'b'
    # assert_equal 'プレイヤー1のカードはハートの7です。',
    # assert_equal 'プレイヤー2のカードはクラブの7です。',
    # assert_equal '引き分けです。',
    # assert_equal '戦争！',
    # assert_equal 'プレイヤー1のカードはダイヤのQです。',
    # assert_equal 'プレイヤー2のカードはスペードの7です。',
    # assert_equal 'プレイヤー1が勝ちました。',
    # assert_equal '戦争を終了します。',
  end
end
