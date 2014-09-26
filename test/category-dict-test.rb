# encoding: utf-8
HOMEDIR = File.expand_path(File.join(File.dirname(__FILE__), '/..'))
require 'test/unit'
require "#{HOMEDIR}/lib/jtext-classifier"

class TestCategoryDict < Test::Unit::TestCase
  def setup
    @obj = JtextClassifier::CategoryDict.new
  end

  def test_ok
    @obj.add_term("it")
    @obj.add_term("news")
    @obj.add_term("economy")
    @obj.add_term("it")
    @obj.save_file
    @obj.clear
    @obj.open_file
    assert_equal(@obj.idx("it"), 0)
    assert_equal(@obj.idx("news"), 1)
    assert_equal(@obj.idx("eco"), nil)
  end
end
