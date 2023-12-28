defmodule TodoWeb.TodosLive do
  use TodoWeb, :live_view

  alias Todo.Odot
  alias Todo.Odot.Todo, as: Todo_

  alias Phoenix.LiveView.JS

  def mount(_params, session, socket) do
    sid = session["session_id"]

    todos = Odot.list_todos(sid)

    socket =
      socket
      |> assign(:mode, :add)
      |> assign(:sid, sid)
      |> assign(:todos, todos)

    {:ok, socket, temporary_assigns: [todos: []]}
  end

  def handle_event("create_todo", _params, %{assigns: %{sid: sid}} = socket) do
    {:noreply, assign(socket, :todos, [Odot.new_todo(sid)])}
  end

  def handle_event(
        "delete_todo",
        %{
          "todo_id" => todo_id
        },
        socket
      ) do
    :ok = Odot.delete_todo(todo_id)
    {:noreply, socket}
  end

  def handle_event(
        "update_todo",
        %{
          "from" => "form",
          "todo_id" => todo_id,
          "todo" => %{"text" => todo_text}
        },
        socket
      ) do
    Odot.update_todo(todo_id, fn todo -> %Todo_{todo | text: todo_text} end)
    {:noreply, socket}
  end

  def handle_event(
        "update_todo",
        %{
          "from" => "text",
          "todo_id" => todo_id,
          "value" => todo_text
        },
        socket
      ) do
    Odot.update_todo(todo_id, fn todo -> %Todo_{todo | text: todo_text} end)
    {:noreply, socket}
  end

  def handle_event(
        "update_todo",
        %{
          "from" => "done",
          "todo_id" => todo_id,
          "value" => "off"
        },
        socket
      ) do
    Odot.update_todo(
      todo_id,
      fn todo -> %Todo_{todo | done: true} end
    )

    {:noreply, socket}
  end

  def handle_event(
        "update_todo",
        %{
          "from" => "done",
          "todo_id" => todo_id,
          "value" => "on"
        },
        socket
      ) do
    Odot.update_todo(
      todo_id,
      fn todo -> %Todo_{todo | done: false} end
    )

    {:noreply, socket}
  end

  def handle_event(
        "toggle_mode",
        _params,
        %{assigns: %{sid: sid, mode: mode}} = socket
      ) do
    new_mode = Map.get(%{add: :del, del: :add}, mode)

    todos = Odot.list_todos(sid)

    socket = assign(socket, mode: new_mode, todos: todos)

    {:noreply, socket}
  end
end
