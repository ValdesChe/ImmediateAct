defmodule ImmediateAct.Petitions.Petition do
  use Ecto.Schema
  import Ecto.Changeset

  schema "petitions" do
    field :description, :string
    field :due_date, :string
    field :goal, :float
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(petition, attrs) do
    petition
    |> cast(attrs, [:title, :description, :goal, :due_date])
    |> validate_required([:title, :description, :goal, :due_date])
  end
end
