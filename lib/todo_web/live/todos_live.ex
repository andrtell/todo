defmodule TodoWeb.TodosLive do
  use TodoWeb, :live_view

  alias Todo.Item
  alias Todo.Store

  def mount(_params, session, socket) do
    dbg session
    dbg socket

    socket =
      socket
      |> assign(:todos, Store.get(session["session_id"]))
      |> assign(:session_id, session["session_id"])
      |> assign(:mode, :edit)

    {:ok, socket}
  end

  def handle_event("toggle_mode", _params, socket) do
    socket =
      case socket.assigns.mode do
        :remove -> assign(socket, :mode, :edit)
        _ -> assign(socket, :mode, :remove)
      end

    {:noreply, socket}
  end

  def handle_event("create", _params, socket) do
    todos =
      case socket.assigns.mode do
        :edit ->
          socket.assigns.todos ++ [Item.new()]

        _ ->
          socket.assigns.todos
      end

    :ok = Store.put(socket.assigns.session_id, todos)
          
    socket = socket |> assign(:todos, todos)

    {:noreply, socket}
  end

  def handle_event("checkmark", %{"id" => id} = _params, socket) do
    todos =
      socket.assigns.todos
      |> Enum.map(fn
        %{id: ^id} = todo -> %{todo | checked: !todo.checked}
        todo -> todo
      end)

    Store.put(socket.assigns.session_id, todos)

    socket = assign(socket, :todos, todos)

    {:noreply, socket}
  end

  def handle_event("remove", %{"id" => id} = _params, socket) do
    todos =
      socket.assigns.todos
      |> Enum.flat_map(fn
        %{id: ^id} = _todo -> []
        todo -> [todo]
      end)

    Store.put(socket.assigns.session_id, todos)

    socket = assign(socket, :todos, todos)

    {:noreply, socket}
  end

  def handle_event("save", %{"id" => id, "value" => text} = _params, socket) do
    todos = update_todos(socket.assigns.todos, %{"id" => id, "text" => text})
    Store.put(socket.assigns.session_id, todos)
    {:noreply, assign(socket, :todos, todos)}
  end

  def handle_event(
        "save",
        %{"id" => id, "item" => %{"text" => text}} = _params,
        socket
      ) do
    todos = update_todos(socket.assigns.todos, %{"id" => id, "text" => text})
    Store.put(socket.assigns.session_id, todos)
    {:noreply, assign(socket, :todos, todos)}
  end

  defp update_todos(todos, %{"id" => id, "text" => text}) do
    todos
    |> Enum.map(fn
      %{id: ^id} = todo -> %Todo.Item{todo | text: text}
      todo -> todo
    end)
  end
end
