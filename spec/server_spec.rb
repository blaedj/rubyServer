require_relative '../lib/server'
require_relative '../testClient'
require 'yaml'


describe Server do
 @port_num = 3001
  before :each do
    @serv = Server.new(3001)
    #@serv.log = LogMock.new
  end

  after :each do
    @serv.shut_down
  end

  it "takes a port parameter and returns Server instance" do
    @serv.should be_an_instance_of Server
  end

  it "should recieve connections" do
    #@serv.run_server
    client = Test_client.new 'localhost', @port_num
    client.run
    true.should be_true
  end

end

# class LogMock

#   def initialize
#   end

#   def puts(message)
#   end

# end
