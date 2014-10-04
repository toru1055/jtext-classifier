# encoding: utf-8
module JtextClassifier
  class Training
    TRAIN_COMMAND = "#{HOMEDIR}/liblinear-1.94/train"
    
    def initialize(data_dir = DEFAULT_DATA_DIR)
      @data_dir = data_dir
      @libsvm_train_file = "#{@data_dir}/svm-train.txt"
      @libsvm_model_file = "#{@data_dir}/svm-model.txt"
      @word_dict = WordDict.instance
      @category_dict = CategoryDict.instance
      @df = DocumentFrequency.instance
      @ma = MorphemeAnalyzer.instance
    end

    def make_dictionaries(train_file)
      puts "== Making dictionaries."
      @progress = 0
      open(train_file) do |file|
        file.each do |line|
          @progress += 1
          show_progress
          category, text = Training.category_text(line)
          if text
            @category_dict.add_term(category)
            @ma.get_tf(text).each do |term, freq|
              @word_dict.add_term(term, 1)
            end
            @df.add_text(text)
          end
        end
      end
      @word_dict.save_file(@data_dir)
      @category_dict.save_file(@data_dir)
      @df.save_file(@data_dir)
    end

    def show_progress
      if @progress % 1000 == 0
        puts "progress(#{Time.now}): #{@progress} lines was read."
      end
    end

    def self.category_text(line)
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
      puts "== Making libsvm format file."
      @progress = 0
      @fv = FeatureVector.instance
      @fv.open_files(@data_dir)
      outfile = open(@libsvm_train_file, "w")
      outfile.sync = true
      open(train_file) do |file|
        file.each do |line|
          @progress += 1
          show_progress
          category, text = Training.category_text(line)
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

    def run_training
      puts "== Running liblinear train."
      system(
        "#{TRAIN_COMMAND} -c 0.1 " +
        "#{@libsvm_train_file} " +
        "#{@libsvm_model_file}"
      )
    end
  end
end
