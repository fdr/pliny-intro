require "spec_helper"

RSpec.describe Endpoints::Todos do
  include Committee::Test::Methods
  include Rack::Test::Methods

  def app
    Routes
  end

  def schema_path
    "./schema/schema.json"
  end

  before do
    @todo = Todo.create

    # temporarily touch #updated_at until we can fix prmd
    @todo.updated_at
    @todo.save
  end

  describe 'GET /todos' do
    it 'returns correct status code and conforms to schema' do
      get '/todos'
      assert_equal 200, last_response.status
      assert_schema_conform
    end
  end

=begin
  describe 'POST /todos' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      post '/todos', MultiJson.encode({})
      assert_equal 201, last_response.status
      assert_schema_conform
    end
  end
=end

  describe 'GET /todos/:id' do
    it 'returns correct status code and conforms to schema' do
      get "/todos/#{@todo.id}"
      assert_equal 200, last_response.status
      assert_schema_conform
    end
  end

  describe 'PATCH /todos/:id' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      patch "/todos/#{@todo.id}", MultiJson.encode({})
      assert_equal 200, last_response.status
      assert_schema_conform
    end
  end

  describe 'DELETE /todos/:id' do
    it 'returns correct status code and conforms to schema' do
      delete "/todos/#{@todo.id}"
      assert_equal 200, last_response.status
      assert_schema_conform
    end
  end
end
