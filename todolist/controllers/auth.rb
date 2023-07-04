class Users
  def initialize(user_id = nil)
    @user_id = user_id
    @conn = db_connect
    @table = "users"
  end

  def get_all_users
    return @conn.exec("SELECT * FROM #{@table}")
  end

  def get_user()
    return @conn.exec("
      SELECT * FROM #{@table}
      WHERE id=#{@user_id}")
  end
  
  def get_user_info()
    return @conn.exec("
      SELECT id,first_name,last_name,email,nickname
      FROM #{@table}
      WHERE id=#{@user_id}")
  end

  def get_user_by_email(email)
    return @conn.exec("
     SELECT id,first_name,last_name,email
     FROM #{@table}
     WHERE email='#{email}'")
  end

  def get_user_password_by_email(email)
    return @conn.exec("
     SELECT password
     FROM #{@table}
     WHERE email='#{email}'")
  end

  def register_user(user)
    user_in_db = get_user_by_email(user[:email])
    return nil if user_in_db.ntuples > 0
    return @conn.exec("
      INSERT INTO #{@table}
      (first_name,last_name,nickname,email,password)
      VALUES (
        '#{user[:first_name]}',
        '#{user[:last_name]}',
        '#{user[:nickname]}',
        '#{user[:email]}',
        '#{hash_password(user[:password])}'
      )
      RETURNING first_name,last_name,nickname,email")
  end

  def login_user(user_data)
    token = nil
    user_in_db = get_user_password_by_email(user_data[:email])
    if user_in_db.ntuples > 0
      user_pass = user_data[:password]
      db_pass = user_in_db[0]['password']
      if compare_passwords(db_pass, user_pass)
        token = generate_token({
          # first_name: user_data[:first_name],
          # last_name: user_data[:last_name],
          email: user_data[:email],
        })
      end
    end
    return token
  end
    
  def change_user(user)
    return @conn.exec("
      UPDATE #{@table}
      SET
        first_name='#{user[:first_name]}',
        last_name='#{user[:last_name]}',
        nickname='#{user[:nickname]}',
        email='#{user[:email]}',
        password='#{user[:password]}'
      WHERE id=#{@user_id}
      RETURNING *")
  end


  def check_user_activate
    confirm_in_db = @conn.exec("
      SELECT is_confirmed
      FROM confirmations
      WHERE user_id=#{@user_id}")
    return false if confirm_in_db.ntuples === 0 || confirm_in_db[0]['is_confirmed'] === false
    return true
  end


  def get_confirmation_info
    user_in_db = @conn.exec("
      SELECT *
      FROM confirmations
      WHERE user_id=#{@user_id}")
    return nil if user_in_db.ntuples === 0
    return user_in_db[0]
  end

  def set_confirmation_info
    code = rand(10_000).to_s.rjust(4, '0')
    puts "======================"
    puts "activation code: #{code}"
    puts "======================"
    return @conn.exec("
      INSERT INTO confirmations
      (user_id,confirmation_code)
      VALUES (#{@user_id},#{code})
      RETURNING *")
  end

  def check_activation_code(code)
    user_in_db = get_confirmation_info
    return false if !user_in_db
    db_confirmation_code = user_in_db['confirmation_code']
    return db_confirmation_code.to_i === code
  end

  def activate_user(code)
    return nil if !check_activation_code code
    return @conn.exec("
      UPDATE confirmations
      SET
        is_confirmed=#{true},
        confirmation_code=#{0}
      WHERE user_id='#{@user_id}'
      RETURNING *")
  end

  # future
  # def activate_user
end