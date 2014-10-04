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
    end

    def open_files(data_dir = DEFAULT_DATA_DIR)
      @word_dict.open_file(data_dir)
      @category_dict.open_file(data_dir)
      @df.open_file(data_dir)
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
