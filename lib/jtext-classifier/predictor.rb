# encoding: utf-8
require 'singleton'
module JtextClassifier
  class Predictor
    include Singleton
    THRESHOLD = -0.55

    def initialize
      @category_dict = CategoryDict.instance
      @fv = FeatureVector.instance
    end

    def read_models(data_dir = DEFAULT_DATA_DIR)
      @fv.open_files(data_dir)
      libsvm_model_file = "#{data_dir}/svm-model.txt"
      @models = Hash.new
      is_weight_start = false
      wid = 0
      open(libsvm_model_file) do |file|
        file.each do |line|
          line.chomp!
          if is_weight_start
            wid += 1
            weights = line.split(" ")
            weights.each_with_index do |weight, cid|
              unless @models[cid]
                @models[cid] = Hash.new
              end
              @models[cid][wid] = weight.to_f
            end
          end
          if line =~ /^w$/
            is_weight_start = true
          end
        end
      end
    end

    def predict(text)
      category = nil
      category_score = THRESHOLD
      text.force_encoding("UTF-8")
      fv = @fv.feature_hash(text)
      @models.each do |cid, model|
        score = 0.0
        fv.each do |wid, tfidf|
          score += tfidf * model[wid]
        end
        if fv.size > 0 && score > category_score
          category_score = score
          category = @category_dict.name(cid)
        end
      end
      return category
    end
  end
end
