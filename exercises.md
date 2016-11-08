# Exercises

In the previous commit, listing and creating todo records has been
demonstrated.  The following exercises will teach a few ways how to
edit a pliny project.

## Run the console and look at the data

The Ruby interpreter is useful for looking at things.  After having
`POST`ed a todo item, inspect the data in the console:

```
$ foreman run ./bin/console
[1] development(main)> Todo.all
```

You can also update these database model objects.  In general,
searching the web with "sequel ruby" will help, e.g. "update model
sequel ruby".

Try creating and destroying Todo objects via the console and seeing
them be reflected via `curl` to the API.

## Render the `body` in the response

Right now, the todo-list API cannot emit the text it has stored,
making it rather useless. Change `lib/serializers/todo.rb` so that
reading the API prints out the `body`.

## Support modifications of the `body`

Implement modifications of the todo text via the `PATCH` method in
`lib/endpoints/todo.rb`.

## Add a new column to store completion status of a todo.

By using `pliny-generate migration add-completion-state`, add a new
completion column to the `todo` table by editing the generated
migration file (see
https://github.com/jeremyevans/sequel/blob/master/doc/schema_modification.rdoc
on how to write migrations, you probably want `alter_table`),
returning it in the API and making it PATCH-able (via more edits to
`lib/endpoints/todo.rb`)

## Support multiple Todo lists

As-is, this application only has one big list of TODOs.  Implement
"todo groups" that allows for multiple lists.

This is a big increase in difficulty that uses everything learned so
far, plus the addition of associating two tables.

As an outline:

* use `pliny-generate scaffold todo-group` to make generate the new
  table/model/endpoint/migration/tests.
  
* make sure to mount the endpoints in `routes.rb`

* for the sake of this exercise, also remember to remove
  `assert_schema_conform`.

* add a new foreign key from `todos` to `todo_groups`.

  * set up a model association in Sequel, see
    http://sequel.jeremyevans.net/rdoc/files/doc/association_basics_rdoc.html
    and `many_to_one` and `one_to_many`.

* find a way to render all the todos in a group. there are at least
  two reasonable ways to do this.
