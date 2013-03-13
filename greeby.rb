require 'sinatra/base'

class Greeby < Sinatra::Base

  get '/' do
    'wip'
  end

  run! if app_file == $0
end
