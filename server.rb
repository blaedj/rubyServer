# main server class

require 'socket'

class Server

  def initialize(port_num)
    @port_num = port_num
    raise "Invalid port number" unless (1024..49100).cover?( @port_num )
    @server = TCPServer.open(@port_num)
    @sockets = [@server]
    @log = STDOUT
    @log.puts "Starting server on port #{@port_num}..."
    run_server
  end


  def run_server
    while true # server loops forever

      ready = select(@sockets) # waits for a socket to be ready
      readable = ready[0]

      readable.each do |socket|
        if socket == @server # server socket is ready
          add_clients
        else # a client socket is ready, process client's request
          process_or_close(socket)
        end
      end

    end
  end

  def add_clients
    client = @server.accept # accept a new client
    @sockets << client # add the client to the set of sockets
    @log.puts "connected to #{socket.peeraddr[2]}" # log the connection
  end

  def process_or_close(socker)
    input = socket.gets
    if input_valid?(input, socket)
      process_input(input, socket)
    else
      next # client disconnected, go to next readable socket
    end
  end


  def input_valid?(input, socket)
    if !input #client has disconnected, no input
      log.puts "client on  #{socket.peeraddr[2]} has disconnected"
      @sockets.delete(socket) #stop monitoring this socket
      socket.close
      return false
    end
    true
  end



  def process_input(input, socket)
    socket.puts("message recieved!")
  end


end
