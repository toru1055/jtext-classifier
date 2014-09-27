# encoding: utf-8
HOMEDIR = File.expand_path(File.join(File.dirname(__FILE__), '/..'))
require 'test/unit'
require "#{HOMEDIR}/lib/jtext-classifier"

class TestWordDict < Test::Unit::TestCase
  def setup
    @obj = JtextClassifier::WordDict.instance
    @ma = JtextClassifier::MorphemeAnalyzer.instance
  end

  def test_ok
    tn = @ma.get_tn("すもももももももものうち")
    p tn
    tn.each do |term, num|
      @obj.add_term(term)
    end
    @obj.save_file
    @obj.clear
    @obj.open_file
    assert_equal(@obj.idx("すもも"), 1)
    assert_equal(@obj.idx("もも"), 2)
    assert_equal(@obj.idx("eco"), nil)
  end
end
