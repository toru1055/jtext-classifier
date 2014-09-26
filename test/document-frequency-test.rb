# encoding: utf-8
HOMEDIR = File.expand_path(File.join(File.dirname(__FILE__), '/..'))
require 'test/unit'
require "#{HOMEDIR}/lib/jtext-classifier"

class TestDocumentFrequency < Test::Unit::TestCase
  def setup
    @obj = JtextClassifier::DocumentFrequency.instance
  end

  def test_ok
    @obj.add_text("すもももももももものうち")
    @obj.add_text("すもももももももものうち")
    @obj.add_text("すもももももももものうち")
    @obj.add_text("すだちともちは別ものです")
    @obj.add_text("すだちともちは別ものです")
    @obj.add_text("すだちもももももものうち")
    t1_idf = @obj.idf("すだち")
    @obj.save_file
    @obj.clear
    @obj.open_file
    t2_idf = @obj.idf("すだち")
    assert_equal(t1_idf, t2_idf)
  end
end
