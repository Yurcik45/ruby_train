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

  def get_user_by_email(email)
    return @conn.exec("
     SELECT *
     FROM #{@table}
     WHERE email='#{email}'")
  end

  def register_user(user)
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
    user_in_db = get_user_by_email(user_data[:email])
    if user_in_db.ntuples > 0
      user_pass = user_data[:password]
      db_pass = user_in_db[0]['password']
      if compare_passwords(db_pass, user_pass)
        token = generate_token({
          first_name: user_data[:first_name],
          last_name: user_data[:last_name],
          nickname: user_data[:nickname]
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

  # future
  # def activate_user
end