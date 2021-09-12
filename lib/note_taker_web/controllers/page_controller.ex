defmodule NoteTakerWeb.PageController do
  use NoteTakerWeb, :controller

  alias NoteTaker.Notes

  def index(conn, _params) do
    notes = Notes.list(conn.assigns.current_user)
    render(conn, "index.html", notes: notes)
  end

  def show(conn, %{"id" => id}) do
    note = Notes.find(id, conn.assigns.current_user)
    render(conn, "show.html", note: note)
  end

  def create(conn, %{"note" => note}) do
    case Notes.create(conn.assigns.current_user, note) do
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
      {:ok, note} ->
        redirect(conn, to: Routes.page_path(conn, :show, note))
    end
    redirect(conn, to: "/")
  end

  def edit(conn, %{"id" => id}) do
    render(conn, "edit.html", id: id)
  end

  def new(conn, _params) do
    changeset = Notes.change(conn.assigns.current_user)
    render(conn, "new.html", changeset: changeset)
  end
end
