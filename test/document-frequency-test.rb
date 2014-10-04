# encoding: utf-8
HOMEDIR = File.expand_path(File.join(File.dirname(__FILE__), '/..'))
require 'test/unit'
require "#{HOMEDIR}/lib/jtext-classifier"

class TestDocumentFrequency < Test::Unit::TestCase
  def setup
    @obj = JtextClassifier::DocumentFrequency.instance
    @data_dir = "#{HOMEDIR}/tmp/data"
  end

  def test_ok
    @obj.add_text("すもももももももものうち")
    @obj.add_text("すもももももももものうち")
    @obj.add_text("すもももももももものうち")
    @obj.add_text("すだちともちは別ものです")
    @obj.add_text("すだちともちは別ものです")
    @obj.add_text("すだちもももももものうち")
    t1_idf = @obj.idf("すだち")
    @obj.save_file(@data_dir)
    @obj.clear
    @obj.open_file(@data_dir)
    t2_idf = @obj.idf("すだち")
    assert_equal(t1_idf, t2_idf)
  end
end
