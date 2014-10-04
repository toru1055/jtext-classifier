# encoding: utf-8
require File.expand_path(File.join(File.dirname(__FILE__), 'dictionary.rb'))

module JtextClassifier
  class WordDict < Dictionary
    def filename
      return "#{@data_dir}/word-dict.txt"
    end

    def add_term(term, start_id = 1)
      super(term, start_id)
    end
  end
end
