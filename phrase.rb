#!/usr/bin/ruby
# encoding: utf-8

require 'yaml'

class DataFile
    def initialize(path)
        @_file_path = path
        @_data = nil
    end

    def pick(word_type, already_used=[])
        _read_file! if @_data.nil?
        word = nil
        while word.nil? or _word_already_used?(word, already_used)
            word = @_data[word_type].sample
        end
        word
    end

    def _word_already_used?(word, already_used)
        already_used.each do |au|
            if au.end_with?(word)
                return true
            end
        end
        return false
    end

    def _read_file!
        f = open(@_file_path)
        @_data = YAML.load(f)
        f.close
    end
end

class PhrasePattern
    attr_accessor :words

    def initialize; @words = []; end

    def parse!(pattern_text)
        t = pattern_text
        indef_article = false
        no_the = false
        until t.empty?
            if t =~ /^\^indef_article\^ (.*)/
                indef_article = true
                t = $1
            elsif t =~ /^\^capitalize\^ (.*)/
                capitalize = true
                t = $1
            elsif t =~ /^\^no_the\^ (.*)/
                no_the = true
                t = $1
            elsif t =~ /^\^(.*?)\^(.*)/
                @words << Word.new($1, :indef_article => indef_article, :no_the => no_the, :capitalize => capitalize)
                t = $2
                capitalize = false
                indef_article = false
                no_the = false
            elsif t =~ /^(.*?)(\^.*)/
                @words << Word.new(:plaintext, :text => $1)
                t = $2
            else
                @words << Word.new(:plaintext, :text => t)
                t = ""
            end
        end
    end
end

class Phrase
    attr_accessor :newline

    def initialize
        @newline = "<br />"
    end

    def generate(path)
        df = DataFile.new(path)

        pattern = PhrasePattern.new
        pattern.parse!(df.pick("pattern"))

        title = ""
        already_used = []
        pattern.words.each do |w|
            picked_word = w.pick(df, already_used)
            title += picked_word
            already_used << picked_word
        end

        title.gsub!(/<br \/>/, @newline)
        title
    end
end

class Word
    attr_accessor :type, :indef_article, :no_the, :capitalize, :text

    def initialize(type, options={})
        @type = type

        @indef_article = options[:indef_article] if options.key?(:indef_article)
        @capitalize = options[:capitalize] if options.key?(:capitalize)
        @no_the = options[:no_the] if options.key?(:no_the)
        # Gets set if this word is plaintext instead of a macro
        @text = options[:text] if options.key?(:text)
    end

    def pick(data_file, already_used=[])
        return @text if @type == :plaintext

        word = data_file.pick(@type, already_used)
        if @indef_article
            uppercase = (word[0].upcase == word[0])
            if word =~ /^[æaeioøœu]/i
                word = (uppercase ? "An " : "an ") + word
            else
                word = (uppercase ? "A " : "a ") + word
            end
        end
        if @capitalize
            word[0] = word[0].upcase
        end
        if @no_the
            word.sub!(/^the /i, "")
        end

        word
    end
end

if $0 == __FILE__
    t = Phrase.new
    data_path = ARGV[0]
    puts t.generate(data_path)
end
