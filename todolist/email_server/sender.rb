require 'net/smtp'

def send_email(sender, recipient, subject, body)
  message = <<~MESSAGE
    From: #{sender}
    To: #{recipient}
    Subject: #{subject}

    #{body}
  MESSAGE

  smtp = Net::SMTP.new('your_smtp_server', 587)
  smtp.enable_starttls

  smtp.start('your_domain', 'your_username', 'your_password', :login) do |smtp|
    smtp.send_message(message, sender, recipient)
  end
end

# Example usage
sender = 'sender@example.com'
recipient = 'recipient@example.com'
subject = 'Hello, World!'
body = 'This is the email content.'

send_email(sender, recipient, subject, body)
