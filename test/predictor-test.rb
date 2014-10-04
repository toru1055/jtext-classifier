# encoding: utf-8
HOMEDIR = File.expand_path(File.join(File.dirname(__FILE__), '/..'))
require 'test/unit'
require "#{HOMEDIR}/lib/jtext-classifier"

class TestPredictor < Test::Unit::TestCase
  def setup
    @data_dir = "#{HOMEDIR}/tmp/data"
    @obj = JtextClassifier::Predictor.instance
    @obj.read_models(@data_dir)
  end

  def test_predict
    category = @obj.predict("USBを気軽にBluetoothで飛ばしてしまうアレがもうすぐ発売されます！")
    assert_equal(category, "it")
    category = @obj.predict("27歳生保レディだけど、はてな婚したい。")
    assert_equal(category, "life")
  end
end
