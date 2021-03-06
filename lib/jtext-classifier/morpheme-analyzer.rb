# encoding: utf-8
require 'singleton'
require 'okura/serializer'

module JtextClassifier
  class MorphemeAnalyzer
    include Singleton
    include Okura
    MA_DICT_DIR = "#{HOMEDIR}/dict/okura-dict"

    def initialize
      @tagger = Serializer::FormatInfo.create_tagger(MA_DICT_DIR)
    end

    def get_tn(sentence)
      tn = Hash.new(0)
      t = @tagger.parse(sentence)
      t.mincost_path.each do |node|
        m = node.word
        if(m.left.text =~ /^名詞,/ ||
           m.left.text =~ /^形容詞,/ ||
           m.left.text =~ /^動詞,/)
          if m.left.text !~ /^名詞,数,/
            tn[m.surface] += 1
          end
        end
      end
      return tn
    end

    def get_tf(sentence)
      tn = get_tn(sentence)
      tn_sum = 0
      tn.each do |term, num|
        tn_sum += num
      end
      tf = Hash.new(0.0)
      if tn_sum > 0
        tn.each do |term, num|
          tf[term] = num.to_f / tn_sum
        end
      end
      return tf
    end
  end
end
