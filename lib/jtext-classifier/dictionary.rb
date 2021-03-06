# encoding: utf-8
module JtextClassifier
  class Dictionary
    include Singleton
    def initialize
      self.clear
    end

    def filename
      return nil
    end

    def clear
      @dict = Hash.new(nil)
      @inverse_dict = Hash.new(nil)
    end

    def open_file(data_dir = DEFAULT_DATA_DIR)
      @data_dir = data_dir
      clear
      open(filename) do |file|
        file.each do |line|
          line.chomp!
          line.force_encoding("UTF-8")
          term, idx = line.split("\t")
          @dict[term] = idx.to_i
          @inverse_dict[idx.to_i] = term
        end
      end
    end

    def add_term(term, start_id = 0)
      #term.force_encoding("UTF-8")
      unless @dict[term]
        @dict[term] = @dict.length + start_id
      end
    end

    def save_file(data_dir = DEFAULT_DATA_DIR)
      @data_dir = data_dir
      open(filename, "w") do |file|
        @dict.each do |term, idx|
          file.write(term.to_s + "\t" + 
                     idx.to_s + "\n")
        end
      end
    end

    def idx(term)
      #term.force_encoding("UTF-8")
      return @dict[term]
    end

    def name(cid)
      return @inverse_dict[cid]
    end
  end
end
