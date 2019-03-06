require 'rubygems'
require 'bundler'
Bundler.require

require 'sinatra'
require 'erb'
require_relative 'phrase'
require_relative 'config'

conf = Config.get

set :bind, '0.0.0.0'
set :port, conf.port

get '/' do
    p = Phrase.new()
	erb = ERB.new(File.read(conf.template_path))
	erb.result_with_hash({
        :phrase => p.generate(conf.data_path)
    })
end
