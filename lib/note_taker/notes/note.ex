defmodule NoteTaker.Notes.Note do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notes" do
    field :title, :string, null: false
    field :body, :string, null: false
    belongs_to :user, NoteTaker.Accounts.User

    timestamps()
  end

  def changeset(%__MODULE__{} = note, attrs \\ %{}) do
    note
    |> cast(attrs, [:title, :body, :user_id])
    |> validate_required([:title, :body, :user_id])
    |> unique_constraint([:title, :user_id])
    |> assoc_constraint(:user)
  end
end
