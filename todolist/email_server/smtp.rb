require 'smtp_server'

class MySMTPServer < SMTPServer::Server
  def start
    puts 'SMTP server started and ready to accept connections...'
  end

  def receive_sender(sender)
    puts "Received sender: #{sender}"
    @sender = sender
    true
  end

  def receive_recipient(recipient)
    puts "Received recipient: #{recipient}"
    @recipient = recipient
    true
  end

  def receive_data_chunk(data)
    puts "Received data chunk: #{data}"
    @data ||= ''
    @data += data
    true
  end

  def receive_message
    puts 'Received entire message.'
    send_email(@sender, @recipient, '', @data)
    true
  end

  def connection_terminated
    puts 'Connection terminated.'
  end
end

server = MySMTPServer.new('0.0.0.0', 2525)
server.start
