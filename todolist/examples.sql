INSERT INTO users (first_name,last_name,nickname,email,password)
VALUES (
        'Yurcik',
        'Yurcik_Last',
        'yurcik45',
        'yurcik45mail@gmail.com',
        'password1'
      )
RETURNING *;