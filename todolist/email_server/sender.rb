require 'net/smtp'

def send_email(sender, recipient, subject, body)
  message = <<~MESSAGE
    From: #{sender}
    To: #{recipient}
    Subject: #{subject}

    #{body}
  MESSAGE

  smtp = Net::SMTP.new('localhost', 2525)  # Update with the SMTP server address and port
  smtp.enable_starttls

  smtp.start do |smtp|
    smtp.send_message(message, sender, recipient)
  end
end

# Example usage
sender = 'sender@example.com'
recipient = 'recipient@example.com'
subject = 'Hello, World!'
body = 'This is the email content.'

send_email(sender, recipient, subject, body)
