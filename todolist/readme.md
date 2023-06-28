## Get all tasks

### Request

`GET /items/`

curl -X GET -H 'Content-Type: application/json' http://localhost:4567/items

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

curl -X GET -H 'Content-Type: application/json' http://localhost:4567/items/2

### Response
<pre>
{
  "id": "2",
  "task": "new task",
  "completed": "f"
}
</pre>

## Create a new Task

### Request

`POST /items/`

curl -X POST -H 'Content-Type: application/json' -d '{"task":"new curl task", "completed":false}' http://localhost:4567/items

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

## Edit task

### Request

`PUT /items/:id`

curl -X PUT -H 'Content-Type: application/json' -d '{"task":"updated text", "completed":true}' http://localhost:4567/items/2

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

## Delete task

### Request

`DELETE /items/:id`

curl -X DELETE -H 'Content-Type: application/json' http://localhost:4567/items/2

### Response
<pre>
{
  "id": "2",
  "task": "updated text",
  "completed": "f"
}
</pre>