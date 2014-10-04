# encoding: utf-8
require File.expand_path(File.join(File.dirname(__FILE__), 'dictionary.rb'))

module JtextClassifier
  class CategoryDict < Dictionary
    def filename
      return "#{@data_dir}/category-dict.txt"
    end
  end
end
