defmodule Todo.Odot.Todo do
  use Ecto.Schema

  import Ecto.Changeset

  embedded_schema do
    field :list_id, :string
    field :text, :string
    field :done, :boolean
  end

  def changeset(%__MODULE__{} = todo, attrs \\ %{}) do
    todo
    |> cast(attrs, [:text, :done])
  end

  def new(list_id) do
    id =
      for _ <- 1..5,
          into: "",
          do: <<Enum.random(~c"0123456789abcedfghijklmnopqrstuvxyz")>>

    %__MODULE__{id: id, list_id: list_id, done: false}
  end
end
