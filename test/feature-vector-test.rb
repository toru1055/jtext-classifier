# encoding: utf-8
HOMEDIR = File.expand_path(File.join(File.dirname(__FILE__), '/..'))
require 'test/unit'
require "#{HOMEDIR}/lib/jtext-classifier"

class TestFeatureVector < Test::Unit::TestCase
  def setup
    @obj = JtextClassifier::FeatureVector.instance
  end
  
  def test_ok
    libsvm = @obj.libsvm_line("it", "すももももも食べ物よ")
    libsvm2 = @obj.libsvm_line("news", "もものうち")
    fv = @obj.feature_hash("もものうち")
    p libsvm
    p libsvm2
    p fv
    assert_equal(libsvm, "0 1:0.23105 2:0.13516")
    assert_equal(libsvm2, "1 2:0.20273 3:0.20273")
    assert(fv[2] > 0.2 && fv[2] < 0.21)
  end
end
