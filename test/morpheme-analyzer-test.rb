# encoding: utf-8
HOMEDIR = File.expand_path(File.join(File.dirname(__FILE__), '/..'))
require 'test/unit'
require "#{HOMEDIR}/lib/jtext-classifier"

class TextMorphemeAnalyzer < Test::Unit::TestCase
  include JtextClassifier
  def setup
    @obj = MorphemeAnalyzer.instance
  end

  def test_ok
    tn = @obj.get_tn("すもももももももものうち")
    p tn
    assert_equal(tn["すもも"], 1)
  end
end
