# encoding: utf-8
require 'singleton'
require File.expand_path(File.join(File.dirname(__FILE__), 'morpheme-analyzer'))

module JtextClassifier
  class DocumentFrequency
    include Singleton
    DF_DICT_FILE = "#{HOMEDIR}/dict/df.txt"
    MIN_DF_NUM = 2

    def initialize
      @ma = MorphemeAnalyzer.instance
      clear
    end

    def clear
      @df = Hash.new(0.0)
      @doc_size = 0
    end

    def open_file(filename = DF_DICT_FILE)
      clear
      open(filename) do |file|
        file.each do |line|
          line.chomp!
          line.force_encoding("UTF-8")
          k,v = line.split("\t")
          if k == "\001DOCSIZE\001"
            @doc_size = v.to_i
          end
          @df[k] = v.to_f
        end
      end
    end

    def add_text(text)
      @doc_size += 1
      text.force_encoding("UTF-8")
      tf = @ma.get_tf(text)
      tf.keys.each do |term|
        @df[term] += 1.0
      end
    end

    def save_file(filename = DF_DICT_FILE)
      open(filename, "w") do |file|
        file.write("\001DOCSIZE\001" + "\t" + 
                   @doc_size.to_s + "\n")
        @df.each do |k,v|
          if v > MIN_DF_NUM
            file.write(k.to_s + "\t" + 
                       v.to_s + "\n")
          end
        end
      end
    end

    def idf(term)
      term.force_encoding("UTF-8")
      if term =~ /^[wｗ]{3,9999}$/
        return 0.0
      end
      if @df[term] && @df[term] > MIN_DF_NUM
        return Math.log(@doc_size / @df[term])
      else 
        return Math.log(@doc_size / MIN_DF_NUM)
      end
    end

    def tfidf(sentence)
      tf = @ma.get_tf(sentence)
      return tf2tfidf(tf)
    end

    def tf2tfidf(tf)
      tfidf = Hash.new
      tf.each do |term, freq|
        tfidf[term] = freq * idf(term)
      end
      return tfidf
    end
  end
end
