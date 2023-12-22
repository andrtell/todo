defmodule Todo.Item do
  use Ecto.Schema

  import Ecto.Changeset

  embedded_schema do
    field :text, :string
    field :checked, :boolean
  end

  def changeset(%Todo.Item{} = item, attrs \\ %{}) do
    item
    |> cast(attrs, [:text, :id, :checked])
  end

  def new() do
    id =
      for _ <- 1..5,
          into: "",
          do: <<Enum.random(~c"0123456789abcedfghijklmnopqrstuvxyz")>>

    %Todo.Item{id: id}
  end
end
