# encoding: utf-8
HOMEDIR = File.expand_path(File.join(File.dirname(__FILE__), '/..'))
require 'test/unit'
require "#{HOMEDIR}/lib/jtext-classifier"

class TestTraining < Test::Unit::TestCase
  def setup
    @fname = "#{HOMEDIR}/tmp/train.tsv.sample"
    @data_dir = "#{HOMEDIR}/tmp/data"
    @obj = JtextClassifier::Training.new(@data_dir)
  end

  def test_make_directories
    @obj.make_dictionaries(@fname)
  end

  def test_make_libsvm
    @obj.make_libsvm(@fname)
  end

  def test_run_training
    @obj.run_training
  end
end
