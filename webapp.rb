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

def template_path(phrase_type)
    conf = Config.get
    puts "conf.template_dir: #{conf.template_dir}"
    puts "phrase_type: #{phrase_type}"
    File.join(conf.template_dir, "#{phrase_type}.erb")
end

def data_path(phrase_type)
    conf = Config.get
    File.join(conf.data_dir, "#{phrase_type}.yaml")
end

get '/:phrase_type' do
    p = Phrase.new()
	erb = ERB.new(File.read(template_path(params['phrase_type'])))
	erb.result_with_hash({
        :phrase => p.generate(data_path(params['phrase_type']))
    })
end
