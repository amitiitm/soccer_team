# File:  tc_ranking.rb

require_relative '../ranking'
require 'test/unit'

class TestRanking < Test::Unit::TestCase
  def test_sample1
    output = { 'Tarantulas' => 6, 'Lions' => 5, 'FC Awesome' => 1, 'Snakes' => 1, 'Grouches' => 0 }
    ranking = Ranking.new('sample-input')
    assert_equal(output, ranking.team_score)
  end

  def test_sample2
    output = { 'Lions' => 10, 'FC Awesome' => 7, 'Tarantulas' => 6, 'Snakes' => 3, 'Grouches' => 0 }
    ranking = Ranking.new('sample-input2')
    assert_equal(output, ranking.team_score)
  end

  def test_filenotfound
    assert_raise(RuntimeError) { Ranking.new('sample') }
  end

  def test_filename_space
    assert_raise(RuntimeError) { Ranking.new(' ') }
  end

  def test_filename_nil
    assert_raise(ArgumentError) { Ranking.new('') }
  end
end
