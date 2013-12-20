require_relative './testClient.rb'


port_num = 3009

client = Test_client.new 'localhost', port_num
client.run

client.close_socket
