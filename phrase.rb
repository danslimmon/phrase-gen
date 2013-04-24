#!/usr/bin/ruby
# encoding: utf-8

require 'yaml'

class DataFile
    def initialize(path)
        @_file_path = path
        @_data = nil
    end

    def pick(word_type)
        _read_file! if @_data.nil?
        @_data[word_type].sample
    end

    def _read_file!
        f = open(@_file_path)
        @_data = YAML.load(f)
        f.close
    end
end

class TitlePattern
    attr_accessor :words

    def initialize; @words = []; end

    def parse!(pattern_text)
        t = pattern_text
        indef_article = false
        until t.empty?
            if t =~ /^\^indef_article\^ (.*)/
                indef_article = true
                t = $1
            elsif t =~ /^\^(.*?)\^(.*)/
                @words << Word.new($1, :indef_article => indef_article)
                t = $2
                indef_article = false
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

class Title
    def generate(path)
        df = DataFile.new(path)

        pattern = TitlePattern.new
        pattern.parse!(df.pick("pattern"))

        title = ""
        pattern.words.each do |w|
            title += w.pick(df)
        end

        title
    end
end

class Word
    attr_accessor :type, :indef_article, :text

    def initialize(type, options={})
        @type = type

        @indef_article = options[:indef_article] if options.key?(:indef_article)
        # Gets set if this word is plaintext instead of a macro
        @text = options[:text] if options.key?(:text)
    end

    def pick(data_file)
        return @text if type == :plaintext

        word = data_file.pick(type)
        if @indef_article
            if word =~ /^[æaeioøœu]/i
                word = "An " + word
            else
                word = "A " + word
            end
        end

        word
    end
end

if $0 == __FILE__
    t = Title.new
    data_path = ARGV[0]
    puts t.generate(data_path)
end
