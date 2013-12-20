require 'socket'

class Test_client

  def initialize(hostname, port)
    @hostname = hostname
    @port = port
  end

  def run
    @socket = TCPSocket.new @hostname, @port
    local = ""

    until local.eql? 'q'
      local = gets
      @socket.puts(local)
      puts "response was: "
      puts @socket.gets
    end
  end

  def close_socket
    @socket.close
  end

end
