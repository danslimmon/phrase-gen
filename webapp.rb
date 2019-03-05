require 'sinatra'
require_relative 'phrase'
require_relative 'config'

conf = Config.get

set :bind, '0.0.0.0'
set :views, conf.views_dir

get '/' do
    p = Phrase.new()
    erb :bjork, :locals => {
        :phrase => p.generate(conf.data_path)
    }
end
