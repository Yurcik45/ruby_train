### API Endpoints
| HTTP Verbs | Endpoints | Action |
| --- | --- | --- |
| POST | /users/register | To sign up a new user account |
| POST | /users/register | To login an existing user account |
| GET | /users/info | To get information about the user |
`will be developed...`
| HTTP Verbs | Endpoints |
| --- | --- | --- |
| POST | /users/reset_password |
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

## Get user info

### Request

`GET /users/info`

curl -X GET -H 'Content-Type: application/json' -H 'Authorization: ___token___' http://localhost:4567/users/info

`Authorization error response:`

`status 401`
<pre>
{
  "message": "Authorization error"
}
</pre>

### Response
`status 201`
<pre>
{
  "id" :1,
  "first_name": "Yurcik",
  "last_name": "Yurcik_Last",
  "email": "yurcik45mail@gmail.com",
  "nickname": "yurcik45"
}
</pre>