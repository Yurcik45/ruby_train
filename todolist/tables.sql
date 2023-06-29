CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  nickname VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  is_active BOOLEAN DEFAULT false
);

CREATE TABLE IF NOT EXISTS todolist (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  task VARCHAR(255) NOT NULL,
  completed BOOLEAN DEFAULT false
);

-- -- prew

-- CREATE TABLE IF NOT EXISTS todolist (
--     id SERIAL PRIMARY KEY,
--     task TEXT,
--     completed BOOLEAN DEFAULT false
-- );