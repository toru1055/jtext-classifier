# encoding: utf-8
module JtextClassifier
  HOMEDIR = File.expand_path(File.join(File.dirname(__FILE__), '/..'))
  DEFAULT_DATA_DIR = "#{HOMEDIR}/data"
end

require './lib/jtext-classifier/morpheme-analyzer'
require './lib/jtext-classifier/document-frequency'
require './lib/jtext-classifier/category-dict'
require './lib/jtext-classifier/word-dict'
require './lib/jtext-classifier/feature-vector'
require './lib/jtext-classifier/training'
require './lib/jtext-classifier/predictor'
