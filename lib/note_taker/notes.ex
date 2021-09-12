defmodule NoteTaker.Notes do
  import Ecto.Query, warn: false

  alias NoteTaker.Repo
  alias NoteTaker.Notes.Note
  alias NoteTaker.Accounts.User

  def create(%User{} = owner, attrs \\ %{}) do
    %Note{}
    |> Note.changeset(Map.put(attrs, "user_id", owner.id))
    |> Repo.insert()
  end

  def list(%User{} = owner) do
    q = from n in Note,
      where: n.user_id == ^owner.id

    Repo.all(q)
  end

  def find(id, %User{} = owner) do
    q = from n in Note,
      where: n.id == ^id,
      where: n.user_id == ^owner.id

    Repo.one!(q)
  end

  def change(%User{} = owner) do
    Note.changeset(%Note{}, %{user_id: owner.id})
  end
end
