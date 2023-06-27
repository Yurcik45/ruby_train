require './db_init.rb'

$users_one = Users.new

def show_users
  puts "========= all users"
  $users_one.get_all_users.each do |users|
    puts "id: #{users['id']}"
    puts "name: #{users['name']}"
    puts "age: #{users['age']}"
    puts "--------"
  end
end

# all users
show_users
puts "========= user with id 1"
puts $users_one.get_user(1)[0]
puts "========= add user with name Alex and age 30"
$users_one.add_user("Alex", 30)
show_users
puts "========= get all users and find name Alex then get id"
$alex_id
$users_one.get_all_users.each do |users|
  if users['name'] === "Alex"
    $alex_id = users['id']
  end
end
puts "Alex id is: #{$alex_id}"
puts "change age to 35 in user with id #{$alex_id}"
$users_one.change_age($alex_id, 35)
show_users
puts "change name to Alexxx in user with id #{$alex_id}"
$users_one.change_name($alex_id, "Alexxx")
show_users
puts "delete user with id #{$alex_id}"
$users_one.delete_user($alex_id)
show_users