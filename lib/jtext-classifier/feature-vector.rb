# encoding: utf-8
require 'singleton'
# def set(class, text)
# def libsvm_line
# def feature_hash
module JtextClassifier
  class FeatureVector
    include Singleton
    def initialize
      @word_dict = WordDict.instance
      @class_dict = CategoryDict.instance
      @df_dict = DocumentFrequency.instance
    end
  end
end
