### API Endpoints
| HTTP Verbs | Endpoints | Action |
| --- | --- | --- |
| POST | /users/register | To sign up a new user account |
| POST | /users/register | To login an existing user account |
`will be developed...`
| HTTP Verbs | Endpoints |
| --- | --- | --- |
| POST | /users/reset_password |
| GET | /users/:id |
| PUT | /users/:id |

## Register

### Request

`POST /users/register`

curl -X POST -H 'Content-Type: application/json' -d '{
  "first_name": "Yurcik",
  "last_name": "Lastname",
  "nickname": "yurcik45",
  "email": "yurcik45email@gmail.com",
  "password": "password"
}' http://localhost:4567/users/register

## body
<pre>
{
  "first_name": "Yurcik",
  "last_name": "Lastname",
  "nickname": "yurcik45",
  "email": "yurcik45mail@gmail.com",
  "password": "password"
}
</pre>

### Response if user exists
`status 400`
<pre>
{
  "message": "user with this email already exists"
}
</pre>

### Response
`status 201`
<pre>
{
  "first_name": "Yurcik",
  "last_name": "Lastname",
  "nickname": "yurcik45",
  "email": "yurcik45email@gmail.com"
}
</pre>





## Login

### Request

`POST /users/login`

curl -X POST -H 'Content-Type: application/json' -d '{
  "email": "yurcik45email@gmail.com",
  "password": "password"
}' http://localhost:4567/users/login

##body
<pre>
{
  "email": "yurcik45email@gmail.com",
  "password": "password"
}
</pre>

### Response in incorrect user data case
`status 400`
<pre>
{
  "message": "incorrect email or login"
}
</pre>

### Response
`status 201`
<pre>
  "string_token"
</pre>