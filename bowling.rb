#!/usr/bin/ruby
# encoding: utf-8
require 'test/unit'

class Test_Bowling < Test::Unit::TestCase

	# 本当はデータ駆動テストにしたいけど、なぜかdataメソッドが見つからないと怒られる
	# http://qiita.com/repeatedly/items/727b08599d87af7fa671
	# http://www.clear-code.com/blog/2013/1/23.html

	def test_score_count
		sut = Bowling.new()
		# 点数なし
		actual = sut.score_count([])
		assert_equal([], actual)
		actual = sut.score_count([[1]])
		assert_equal([], actual)
		# 点数あり
		actual = sut.score_count([[0,0]])
		assert_equal([0], actual)
		actual = sut.score_count([[3,6],[9]])
		assert_equal([9], actual)
		# スペア
		actual = sut.score_count([[9,1]])
		assert_equal([], actual)
		actual = sut.score_count([[0,10],[9]])
		assert_equal([19], actual)
		# ストライク
		actual = sut.score_count([[10]])
		assert_equal([], actual)
		actual = sut.score_count([[10],[9]])
		assert_equal([], actual)
		actual = sut.score_count([[10],[9,1]])
		assert_equal([20], actual)
		# ダブル
		actual = sut.score_count([[10],[10]])
		assert_equal([], actual)
		actual = sut.score_count([[10],[10],[9]])
		assert_equal([29], actual)
		actual = sut.score_count([[10],[10],[9,1]])
		assert_equal([29, 20], actual)
		# ターキー
		actual = sut.score_count([[10],[10],[10]])
		assert_equal([30], actual)
		actual = sut.score_count([[10],[10],[10],[9]])
		assert_equal([30, 29], actual)
		actual = sut.score_count([[10],[10],[10],[9,1]])
		assert_equal([30, 29, 20], actual)
	end
end

class Bowling
	def score_count(throw)
		score = []
		throw.each_with_index{ |v, i|
			# フレームが完了しておらず、点数未定の場合
			if v[0] != 10 && v[1].nil? then 
				break
			# ストライクの場合
			elsif v[0] == 10 then
				##### Q3-1.ストライクでまだ点数未定の場合 #####
				##### Q3-2.ダブルかターキーの場合 #####
				##### Q3-3.ストライクで点数が確定している場合（ダブルでもターキーでもない） #####
			# スペアの場合
			elsif v[0] + v[1] == 10 then
				##### Q2-1.スペアでまだ点数未定の場合 #####
				##### Q2-2.スペアでまだ点数が確定している場合 #####
			# その他の場合
			else
				##### Q1.ストライクでもスペアでもなくて、フレームが完了しているとき #####
				##### ヒント：socoreに0値を追加するときは　score << 0　のように #####
			end
		}
		score
	end
end