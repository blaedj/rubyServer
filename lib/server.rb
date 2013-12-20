# main server class

require 'socket'

class Server

  # attr_accesible log

  def initialize(port_num)
    @port_num = port_num
    if !(1024..49100).cover?( @port_num )
      raise "Invalid port number: #{@port_num}"
    end
    @server = TCPServer.new @port_num
    @sockets = [@server]
    @log = STDOUT
  end

  def run_server
    @log.puts "Starting server on port #{@port_num}..."
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
    @log.puts "connected to #{client.peeraddr[2]}" # log the connection
  end

  def process_or_close(socket)
    input = socket.gets
    if input_valid?(input)
      process_input(input, socket)
    else
      close_socket(socket)
    end
  end


  def input_valid?(input)
    if !input #client has disconnected, no input
      @log.puts "no request message"
      return false
    end
    true
  end

  def close_socket(socket)
    @log.puts "client on  #{socket.peeraddr[2]} has disconnected"
    @sockets.delete(socket) #stop monitoring this socket
    socket.close
  end

  def process_input(input, socket)
    temp_processor(input, socket)


  end

  def shut_down
    @sockets.each do |socket|
      socket.close
    end
  end

  def temp_processor(input, socket)
    socket.puts("message recieved!")
    @log.puts " recieved: '#{input.chomp}'"
  end

end
