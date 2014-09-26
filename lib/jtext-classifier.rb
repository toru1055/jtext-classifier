# encoding: utf-8
module JtextClassifier
  HOMEDIR = File.expand_path(File.join(File.dirname(__FILE__), '/..'))
end

require './lib/jtext-classifier/morpheme-analyzer'
require './lib/jtext-classifier/document-frequency'
require './lib/jtext-classifier/category-dict.rb'
