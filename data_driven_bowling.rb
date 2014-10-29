#!/usr/bin/ruby
# encoding: utf-8
require 'test/unit'

class TestBowling < Test::Unit::TestCase
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

class Bowling
	def score_count(throw)
		score = []
		throw.each_with_index{ |v, i|
			# フレームが完了しておらず、点数未定の場合
			if v[0] != 10 && v[1].nil? then 
				break
			# ストライクの場合
			elsif v[0] == 10 then
				# ストライクでまだ点数未定の場合 
				if (throw[i+1].nil? ? 0 : throw[i+1].size) + (throw[i+2].nil? ? 0 : throw[i+2].size) < 2 then
					break
				# ダブルかターキーの場合
				elsif throw[i+1][0] == 10 then
					score << 20 + throw[i+2][0]
				else
					score << 10 + throw[i+1][0] + throw[i+1][1]
				end
			# スペアの場合
			elsif v[0] + v[1] == 10 then
				# スペアでまだ点数未定の場合
				if throw[i+1].nil? then
					break
				else
					score << 10 + throw[i+1][0]
				end
			# その他の場合
			else
				score << v[0] + v[1]
			end
		}
		score
	end
end