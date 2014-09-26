# encoding: utf-8
require File.expand_path(File.join(File.dirname(__FILE__), 'dictionary.rb'))

module JtextClassifier
  class CategoryDict < Dictionary
    DICT_FILE = "#{HOMEDIR}/dict/category-dict.txt"
    def initialize(fname = DICT_FILE)
      super
      @filename = fname
    end
  end
end
