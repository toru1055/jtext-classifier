# encoding: utf-8
require 'singleton'
module JtextClassifier
  class Training
    include Singleton
    LIBSVM_TRAIN_FILE = "#{HOMEDIR}/data/svm-train.txt"
    LIBSVM_MODEL_FILE = "#{HOMEDIR}/data/svm-model.txt"
    
    def initialize
      @word_dict = WordDict.instance
      @category_dict = CategoryDict.instance
      @df = DocumentFrequency.instance
      @ma = MorphemeAnalyzer.instance
    end

    def make_dictionaries(train_file)
      @progress = 0
      open(train_file) do |file|
        file.each do |line|
          @progress += 1
          show_progress
          category, text = category_text(line)
          if text
            @category_dict.add_term(category)
            @ma.get_tf(text).each do |term, freq|
              @word_dict.add_term(term, 1)
            end
            @df.add_text(text)
          end
        end
      end
      @word_dict.save_file
      @category_dict.save_file
      @df.save_file
    end

    def show_progress
      if @progress % 1000 == 0
        puts "progress(#{Time.now}): #{progress} lines was read."
      end
    end

    def category_text(line)
      line.chomp!
      line.force_encoding("UTF-8")
      category, text_array = line.split("\t")
      if text_array.instance_of?(Array)
        text = text_array.join("。")
      elsif text_array.instance_of?(String)
        text = text_array
      else
        text = nil
      end
      return category, text
    end

    def make_libsvm(train_file)
      @fv = FeatureVector.instance
      outfile = open(LIBSVM_TRAIN_FILE, "w")
      outfile.sync = true
      open(train_file) do |file|
        file.each do |line|
          category, text = category_text(line)
          if text
            libsvm = @fv.libsvm_line(category, text)
            if libsvm
              outfile.write(libsvm + "\n")
            end
          end
        end
      end
      outfile.close
    end
  end
end
