# encoding: utf-8
require 'singleton'
module JtextClassifier
  class FeatureVector
    include Singleton

    def initialize
      @word_dict = WordDict.instance
      @category_dict = CategoryDict.instance
      @df = DocumentFrequency.instance
      @ma = MorphemeAnalyzer.instance
      open_files
    end

    def open_files
      @word_dict.open_file
      @category_dict.open_file
      @df.open_file
    end

    def libsvm_line(category, text)
      cid = @category_dict.idx(category)
      return nil unless cid
      libsvm = Array.new
      libsvm.push(cid.to_s)
      feature_hash(text).sort.each do |wid, tfidf|
        libsvm.push("#{wid}:#{sprintf("%.5f",tfidf)}")
      end
      if libsvm.length >= 2
        return libsvm.join(" ")
      else
        return nil
      end
    end

    def feature_hash(text)
      fv = Hash.new(0.0)
      @ma.get_tf(text).each do |term, freq|
        wid = @word_dict.idx(term)
        if wid
          fv[wid] = freq * @df.idf(term)
        end
      end
      return fv
    end
  end
end
