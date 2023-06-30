### API Endpoints
| HTTP Verbs | Endpoints | Action |
| --- | --- | --- |
| GET | /items | To get all todos items |
| GET | /items/:id | To get a particular todos item |
| POST | /items | To create a new todo |
| PUT | /items/:id | To edit the details of a single todo |
| DELETE | /items/:id | To delete a single todo |




### Authorization header is required!

`Authorization error response:`

`status 401`
<pre>
{
  "message": "Authorization error"
}
</pre>

### All required headers
<pre>
{
  "Authorization": "token",
  "Content-Type": "application/json",
}
</pre>


## Get all tasks

### Request

`GET /items/`

curl -X GET -H 'Content-Type: application/json' -H 'Authorization: ___token___' http://localhost:4567/items

### Response
<pre>
[
  {
    "id": "2",
    "task":"newtask",
    "completed": "f"
  },
  {
    "id": "3",
    "task": "new curl task",
    "completed":"f"
  }
]
</pre>

## Get one task

### Request

`GET /items/:2`

curl -X GET -H 'Content-Type: application/json' -H 'Authorization: ___token___' http://localhost:4567/items/2

### Response
<pre>
{
  "id": "2",
  "task": "new task",
  "completed": "f"
}
</pre>

### Response if item with selected id desn't exist
<pre>
{
  "message": "no items was found with id 2"
}
</pre>

## Create a new Task

### Request

`POST /items/`

curl -X POST -H 'Content-Type: application/json' -H 'Authorization: ___token___' -d '{"task":"new curl task", "completed":false}' http://localhost:4567/items

## body
<pre>
{
 "task": "new task"
}
</pre>

### Response
<pre>
{
  "id": "2",
  "task": "new task",
  "completed": "f"
}
</pre>

### Response if item with selected id desn't exist
<pre>
{
  "message": "something went wrong"
}
</pre>

## Edit task

### Request

`PUT /items/:id`

curl -X PUT -H 'Content-Type: application/json' -H 'Authorization: ___token___' -d '{"task":"updated text", "completed":true}' http://localhost:4567/items/2

## body
<pre>
{
  "task": "updated text",
  "completed": true
}
</pre>

### Response
<pre>
{
  "id": "2",
  "task": "updated text",
  "completed": "t"
}
</pre>
### Response if item with selected id desn't exist
<pre>
{
  "message": "something went wrong"
}
</pre>

## Delete task

### Request

`DELETE /items/:id`

curl -X DELETE -H 'Content-Type: application/json' -H 'Authorization: ___token___' http://localhost:4567/items/2

### Response
<pre>
{
  "id": "2",
  "task": "updated text",
  "completed": "f"
}
</pre>
### Response if item with selected id desn't exist
<pre>
{
  "message": "something went wrong"
}
</pre>