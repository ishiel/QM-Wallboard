require "xmlrpc/client"
require "configatron"     #ver: 2.6.3

class Agent
  attr_accessor :name, :paused, :pause_time

  def initialize(name,pause_time,ongoing)
    @name       = name
    @pause_time = pause_time

    @paused = true
    @paused = false if @pause_time=="-"
    # this ugly nest determines if the agent has an ongoing call. if so, reports them as paused
    unless ongoing==nil 
      call = ongoing.find{|call| call.agent == @name}
      if call
        if @paused==false
          @paused = true
          @pause_time =  "#{call.entered} on a call"
        end
      end
    end
  end
end

class Call
  attr_accessor :source, :waiting, :agent, :incoming, :entered, :duration, :too_long

  def initialize(source,waiting,agent,entered,duration)
    @source   = source
    @waiting  = waiting
    @agent    = agent
    @entered  = entered
    @duration = duration

    @agent=="" ? @incoming = true : @incoming = false

    @waiting[/(\d+):/].to_i >= 1 ? @too_long = true : @too_long = true   # if > 1min then it's too long!
  end
end

class Qmetrics
  attr_accessor :agents, :calls, :incoming, :ongoing

  def initialize(config_file)
    config = load_config(config_file)

    # Make an object to represent the XML-RPC server
    server = XMLRPC::Client.new(config.server, config.path, config.port.to_s)

    # QMetrics settings
    logfile  = ""	
    agent    = ""
    list     = ["RealtimeDO.RTAgentsLoggedIn","RealtimeDO.RTCallsBeingProc"]

    # Call the remote server and get our result
    @result = server.call("QM.realtime", config.queue, config.user, config.password, logfile, agent, list)
    @calls  = calls_arr
    @incoming, @ongoing = calls_group
    @agents = agents_arr
  end

private
  def load_config(config_file)
    configatron.configure_from_yaml config_file
    config = configatron
  end

  def agents_arr
    agents_arr = Array.new
    agents = @result["RealtimeDO.RTAgentsLoggedIn"]
    agents.shift
    agents.each {|agent|
      a = Agent.new(agent[1], agent[6], @ongoing)
      agents_arr << a
    }
    agents_arr
  end

  def calls_arr
    calls_arr  = Array.new
    calls = @result["RealtimeDO.RTCallsBeingProc"]
    calls.shift
    calls.each {|call|
      c = Call.new(call[2],call[4],call[6],call[3],call[5])
      calls_arr << c
    }
    calls_arr
  end

  def calls_group
    calls = @calls.group_by {|call| call.incoming }
    return calls[true], calls[false]
  end
end


