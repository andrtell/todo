defmodule Todo.Odot.Store do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def list_todos(list_id),
    do:
      Agent.get(
        __MODULE__,
        fn todos ->
          todos
          |> Enum.filter(fn todo -> todo.list_id == list_id end)
          |> Enum.reverse()
        end
      )

  def insert_todo(todo),
    do:
      Agent.update(
        __MODULE__,
        fn todos -> [todo | todos] end
      )

  def get_todo(todo_id),
    do:
      Agent.get(
        __MODULE__,
        &Enum.find(&1, fn todo -> todo_id == todo.id end)
      )

  def update_todo(todo_id, fun),
    do:
      Agent.update(
        __MODULE__,
        &Enum.map(&1, fn todo ->
          if todo.id == todo_id, do: fun.(todo), else: todo
        end)
      )

  def delete_todo(todo_id),
    do:
      Agent.update(
        __MODULE__,
        fn todos ->
          todos |> Enum.filter(fn todo -> todo.id != todo_id end)
        end
      )
end
