defmodule Todo.Store do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get(id), do: Agent.get(__MODULE__, &Map.get(&1, id, []))
  def put(id, todos), do: Agent.update(__MODULE__, &Map.put(&1, id, todos))
end
