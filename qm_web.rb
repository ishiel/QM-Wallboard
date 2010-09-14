require 'rubygems'
require 'sinatra'   #ver: 1.0
require 'haml'      #ver: 3.0.18
require File.join(File.dirname(__FILE__), 'qm_realtime')

set :config, 'config.yml'

get '/' do
  @qm     = Qmetrics.new(settings.config)
  @agents = @qm.agents
  @calls  = @qm.calls
  haml :index
end

get '/agents' do
  @qm     = Qmetrics.new(settings.config)
  @agents = @qm.agents
  haml :agents
end

get '/incoming' do
  @qm       = Qmetrics.new(settings.config)
  @incoming = @qm.incoming
  haml :incoming
end

get '/ongoing' do
  @qm       = Qmetrics.new(settings.config)
  @ongoing  = @qm.ongoing
  haml :ongoing
end
