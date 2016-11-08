module Endpoints
  class Todos < Base
    namespace "/todos" do
      serializer Serializers::Todo

      get do
        encode serialize(Todo.all)
      end

      post do
        # warning: not safe
        todo = Todo.new(body_params)
        todo.save
        status 201
        encode serialize(todo)
      end

      get "/:id" do |id|
        todo = Todo.first(id: id) || halt(404)
        encode serialize(todo)
      end

      patch "/:id" do |id|
        todo = Todo.first(id: id) || halt(404)
        # warning: not safe
        #todo.update(body_params)
        encode serialize(todo)
      end

      delete "/:id" do |id|
        todo = Todo.first(id: id) || halt(404)
        todo.destroy
        encode serialize(todo)
      end
    end
  end
end
