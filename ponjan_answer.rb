#!/usr/bin/ruby
# encoding: utf-8
require 'test/unit'

# http://ja.wikipedia.org/wiki/%E3%83%9D%E3%83%B3%E3%82%B8%E3%83%A3%E3%83%B3
# 3色9種（親6点・子3点）：絵柄も色も違う9枚の牌を揃える
# ポンジャン（親6点・子3点）：絵柄・色は任意でセットを3つ作る
# 3色（親10点・子5点）：絵柄は任意、赤・黒・青の三色でセットを3つ作る
# 3種（親10点・子5点）：色は任意、船・自動車・飛行機の三種でセットを3つ作る
# 6連（親30点・子15点）：同じ絵柄・色を6枚揃え、任意のセットを1つ作る
# 3種3色（親30点・子15点）：絵柄も色もそれぞれ異なるセットを3つ作る
# 1種3色（親60点・子30点）：同じ絵柄の赤・黒・青の三色でセットを3つ作る
# 3種1色（親60点・子30点）：同じ色の船・自動車・飛行機の三種でセットを3つ作る
# 1色6連（親60点・子30点）：同じ絵柄・色を6枚揃え、それらと同じ色で任意の絵柄のセットを1つ作る
# 1種6連（親80点・子40点）：同じ絵柄・色を6枚揃え、それらと同じ絵柄で任意の色のセットを1つ作る
# 1色9連（親200点・子100点）：同じ絵柄・色を9枚揃える

class Test_Ponjan < Test::Unit::TestCase
	def test_judge
		sut = Ponjan.new()
		# 1色9連
		hand = [
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'}
		]
		actual = sut.judge(hand)
		assert_equal(100, actual)
		# 1種6連
		hand = [
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'black'},
			{'suit' => 'plain', 'color' => 'black'},
			{'suit' => 'plain', 'color' => 'black'}
		]
		actual = sut.judge(hand)
		assert_equal(40, actual)
		# 1色6連
		hand = [
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'car', 'color' => 'red'},
			{'suit' => 'car', 'color' => 'red'},
			{'suit' => 'car', 'color' => 'red'}
		]
		actual = sut.judge(hand)
		assert_equal(30, actual)
		# 3種1色
		hand = [
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'ship', 'color' => 'red'},
			{'suit' => 'ship', 'color' => 'red'},
			{'suit' => 'ship', 'color' => 'red'},
			{'suit' => 'car', 'color' => 'red'},
			{'suit' => 'car', 'color' => 'red'},
			{'suit' => 'car', 'color' => 'red'}
		]
		actual = sut.judge(hand)
		assert_equal(30, actual)

		# 1種3色
		hand = [
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'black'},
			{'suit' => 'plain', 'color' => 'black'},
			{'suit' => 'plain', 'color' => 'black'},
			{'suit' => 'plain', 'color' => 'blue'},
			{'suit' => 'plain', 'color' => 'blue'},
			{'suit' => 'plain', 'color' => 'blue'}
		]
		actual = sut.judge(hand)
		assert_equal(30, actual)

		# 3種3色
		hand = [
			{'suit' => 'ship', 'color' => 'red'},
			{'suit' => 'ship', 'color' => 'red'},
			{'suit' => 'ship', 'color' => 'red'},
			{'suit' => 'car', 'color' => 'black'},
			{'suit' => 'car', 'color' => 'black'},
			{'suit' => 'car', 'color' => 'black'},
			{'suit' => 'plain', 'color' => 'blue'},
			{'suit' => 'plain', 'color' => 'blue'},
			{'suit' => 'plain', 'color' => 'blue'}
		]
		actual = sut.judge(hand)
		assert_equal(15, actual)

		# 6連
		hand = [
			{'suit' => 'ship', 'color' => 'red'},
			{'suit' => 'ship', 'color' => 'red'},
			{'suit' => 'ship', 'color' => 'red'},
			{'suit' => 'ship', 'color' => 'red'},
			{'suit' => 'ship', 'color' => 'red'},
			{'suit' => 'ship', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'blue'},
			{'suit' => 'plain', 'color' => 'blue'},
			{'suit' => 'plain', 'color' => 'blue'}
		]
		actual = sut.judge(hand)
		assert_equal(15, actual)

		# 3種
		hand = [
			{'suit' => 'ship', 'color' => 'red'},
			{'suit' => 'ship', 'color' => 'black'},
			{'suit' => 'ship', 'color' => 'blue'},
			{'suit' => 'car', 'color' => 'red'},
			{'suit' => 'car', 'color' => 'red'},
			{'suit' => 'car', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'blue'},
			{'suit' => 'plain', 'color' => 'blue'},
			{'suit' => 'plain', 'color' => 'blue'}
		]
		actual = sut.judge(hand)
		assert_equal(5, actual)

		# 3色
		hand = [
			{'suit' => 'ship', 'color' => 'black'},
			{'suit' => 'car', 'color' => 'black'},
			{'suit' => 'plain', 'color' => 'black'},
			{'suit' => 'car', 'color' => 'red'},
			{'suit' => 'car', 'color' => 'red'},
			{'suit' => 'car', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'blue'},
			{'suit' => 'plain', 'color' => 'blue'},
			{'suit' => 'plain', 'color' => 'blue'}
		]
		actual = sut.judge(hand)
		assert_equal(5, actual)

		# ポンジャン
		hand = [
			{'suit' => 'ship', 'color' => 'black'},
			{'suit' => 'car', 'color' => 'black'},
			{'suit' => 'plain', 'color' => 'black'},
			{'suit' => 'car', 'color' => 'red'},
			{'suit' => 'car', 'color' => 'black'},
			{'suit' => 'car', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'blue'},
			{'suit' => 'plain', 'color' => 'blue'},
			{'suit' => 'ship', 'color' => 'blue'}
		]
		actual = sut.judge(hand)
		assert_equal(3, actual)

		# 3色9種
		hand = [
			{'suit' => 'ship', 'color' => 'red'},
			{'suit' => 'ship', 'color' => 'black'},
			{'suit' => 'ship', 'color' => 'blue'},
			{'suit' => 'car', 'color' => 'red'},
			{'suit' => 'car', 'color' => 'black'},
			{'suit' => 'car', 'color' => 'blue'},
			{'suit' => 'plain', 'color' => 'red'},
			{'suit' => 'plain', 'color' => 'black'},
			{'suit' => 'plain', 'color' => 'blue'}
		]
		actual = sut.judge(hand)
		assert_equal(3, actual)

	end
end

class Ponjan
	module Hand
	  NINE_SERIES = 100
	  ONE_SUITE_SIX_SERIES = 40
	  ONE_COLOR_SIX_SERIES = 30
	  THREE_SUITES_ONE_COLOR = 30
	  ONE_SUITE_THREE_COLORS = 30
	  THREE_SUITES_THREE_COLORS = 15
	  SIX_SERIES = 15
	  THREE_SUITES = 5
	  THREE_COLORS = 5
	  PONJAN = 3
	  THREE_COLORS_NINE_CLASS = 3
	end

	module Suit
		SHIP = 'ship'
		CAR = 'car'
		PLAIN = 'plain'
	end 

	module Color
		RED = 'red'
		BLACK = 'black'
		BLUE = 'blue'
	end

	def judge(hand)
		# 1色9連
		return Hand::NINE_SERIES if hand.uniq.size == 1

		# 手札の絵柄の数を計算
		suit_number = {Suit::SHIP => 0, Suit::CAR => 0, Suit::PLAIN => 0}
		hand.each{ |card| suit_number[card['suit']] += 1 }
		# 手札の色の数を計算
		color_number = {Color::RED => 0, Color::BLACK => 0, Color::BLUE => 0}
		hand.each{ |card| color_number[card['color']] += 1 }

		# 1種6連
		return Hand::ONE_SUITE_SIX_SERIES if suit_number.values.include?(9) && color_number.values.include?(6) && color_number.values.include?(3)
		
		# 1色6連
		return Hand::ONE_COLOR_SIX_SERIES if color_number.values.include?(9) && suit_number.values.include?(6) && suit_number.values.include?(3)

		# 3種1色
		return Hand::THREE_SUITES_ONE_COLOR if suit_number.values.all?{|n| n == 3} && color_number.values.include?(9)

		# 1種3色
		return Hand::ONE_SUITE_THREE_COLORS if suit_number.values.include?(9) && color_number.values.all?{|n| n == 3}

		# 3種3色
		return Hand::THREE_SUITES_THREE_COLORS if hand.uniq.size == 3 && suit_number.values.all?{|n| n == 3} && color_number.values.all?{|n| n == 3}

		# 6連
		return Hand::SIX_SERIES if hand.uniq.size == 2 && suit_number.values.include?(6) && color_number.values.include?(6) && suit_number.values.include?(3) && color_number.values.include?(3)

		# 3色9種
		return Hand::THREE_COLORS_NINE_CLASS if hand.uniq.size == 9

		# 3種
		return Hand::THREE_SUITES if suit_number.values.all?{|n| n == 3}

		# 3色
		return Hand::THREE_COLORS if color_number.values.all?{|n| n == 3}

		# ポンジャン
		return Hand::PONJAN if is_ponjan(hand)
		
		return 0
	end

	def is_set(hand, a, b, c)
		(hand[a]['suit'] == hand[b]['suit'] && hand[b]['suit'] == hand[c]['suit']) || (hand[a]['color'] == hand[b]['color'] && hand[b]['color'] == hand[c]['color']) 
	end

	def is_ponjan(hand, array = [0, 1, 2, 3, 4, 5, 6, 7, 8] )
		array.combination(3){ |a, b, c|
			if array.size == 3 then
				return is_set(hand, a, b, c)
			else
				is_ponjan(hand, array - [a, b, c])
			end
		}
	end
end