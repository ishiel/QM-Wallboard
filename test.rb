require File.join(File.dirname(__FILE__), 'qm_realtime')
require 'pp'

  @qm     = Qmetrics.new('config.yml')
  @agents = @qm.agents
  @calls  = @qm.calls

pp @calls
pp @qm.incoming
pp @qm.ongoing
pp @agents


