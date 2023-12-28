defmodule Todo.Odot do
  alias Todo.Odot.Store
  alias Todo.Odot.Todo

  def list_todos(list_id) do
    Store.list_todos(list_id)
  end

  def new_todo(list_id) do
    todo = Todo.new(list_id)
    Store.insert_todo(todo)
    todo
  end

  def update_todo(todo_id, fun) do
    Store.update_todo(todo_id, fun)
    Store.get_todo(todo_id)
  end

  def delete_todo(todo_id) do
    Store.delete_todo(todo_id)
  end
end
