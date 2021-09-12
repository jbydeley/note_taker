defmodule NoteTaker.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :title, :string, null: false
      add :body, :text, null: false
      add :user_id, references(:users), null: false

      timestamps()
    end

    create index(:notes, [:user_id])
    create unique_index(:notes, [:title, :user_id])
  end
end
