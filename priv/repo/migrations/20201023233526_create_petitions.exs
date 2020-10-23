defmodule ImmediateAct.Repo.Migrations.CreatePetitions do
  use Ecto.Migration

  def change do
    create table(:petitions) do
      add :title, :text
      add :description, :text
      add :goal, :float
      add :due_date, :string

      timestamps()
    end

  end
end
