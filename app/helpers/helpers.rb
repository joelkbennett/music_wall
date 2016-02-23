require 'sinatra/base'

module Sinatra
  module UserLogin
    def login?
      session[:name].nil? ? false : true
    end

    def username
      session[:name]
    end
  end

  helpers UserLogin
end