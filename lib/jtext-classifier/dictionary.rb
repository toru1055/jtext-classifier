# encoding: utf-8
module JtextClassifier
  class Dictionary
    def initialize(fname)
      clear
      @filename = fname
    end

    def clear
      @dict = Hash.new(nil)
    end

    def open_file
      clear
      open(@filename) do |file|
        file.each do |line|
          line.chomp!
          line.force_encoding("UTF-8")
          term, idx = line.split("\t")
          @dict[term] = idx.to_i
        end
      end
    end

    def add_term(term, start_id = 0)
      #term.force_encoding("UTF-8")
      unless @dict[term]
        @dict[term] = @dict.length + start_id
      end
    end

    def save_file
      p @filename
      open(@filename, "w") do |file|
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
  end
end
