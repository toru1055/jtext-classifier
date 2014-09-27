# encoding: utf-8
require File.expand_path(File.join(File.dirname(__FILE__), 'dictionary.rb'))

module JtextClassifier
  class WordDict < Dictionary
    include Singleton
    DICT_FILE = "#{HOMEDIR}/dict/word-dict.txt"
    def initialize(fname = DICT_FILE)
      super
      @filename = fname
    end

    def add_term(term, start_id = 1)
      super(term, start_id)
    end
  end
end
