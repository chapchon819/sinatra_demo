require 'sinatra/base'
require 'sinatra/reloader'
require 'uri'
require 'net/http'
require 'faraday'

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    options = {
      url: 'http://api.weatherapi.com'
    }
    conn = Faraday.new(options) do |f|
      f.response :json
      f.adapter :net_http
      f.request :url_encoded
    end
    req_params = {
      key: '54fc789584ab4cc5a8e111055242703',
      q: 'Tokyo'
    }
    res = conn.get('/v1?&current.json', req_params)
    @whether = res.body['current']
    erb :index
  end
end
