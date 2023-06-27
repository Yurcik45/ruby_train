require './db_init.rb'

users = get_users

# Process the query result
users.each do |row|
  # Access row data
  puts row['name']
  puts row['age']
end