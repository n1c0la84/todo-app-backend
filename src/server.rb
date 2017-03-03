require 'mongoid'
require 'sinatra'
require 'json'

# config
configure do
    Mongoid.load!("./database.yml")
end

# model
class ToDo
    include Mongoid::Document
    field :content, type: String
end

# list all
get '/todo-app/todos' do
    ToDo.all.to_json
end
 
# view one
get '/todo-app/todos/:id' do
    todo = ToDo.find(params[:id])
    return status 404 if todo.nil?
    todo.to_json
end
 
# create
post '/todo-app/todos' do
    params = JSON.parse(request.body.read)
    ToDo.create(content: params['content'])
    status 201
end
 
# update
put '/todo-app/todos/:id' do
    todo = ToDo.find(params[:id])
    return status 404 if todo.nil?
    todo.update(params['content'])
    todo.save
    status 202
end
 
# delete
delete '/todo-app/todos/:id' do
    todo = ToDo.find(params[:id])
    return status 404 if todo.nil?
    todo.delete
    status 202
end
