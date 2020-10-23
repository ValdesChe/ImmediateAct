defmodule ImmediateActWeb.PetitionController do
  use ImmediateActWeb, :controller

  alias ImmediateAct.Petitions
  alias ImmediateAct.Petitions.Petition

  def index(conn, _params) do
    petitions = Petitions.list_petitions()
    render(conn, "index.html", petitions: petitions)
  end

  def new(conn, _params) do
    changeset = Petitions.change_petition(%Petition{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"petition" => petition_params}) do
    case Petitions.create_petition(petition_params) do
      {:ok, petition} ->
        conn
        |> put_flash(:info, "Petition created successfully.")
        |> redirect(to: Routes.petition_path(conn, :show, petition))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    petition = Petitions.get_petition!(id)
    render(conn, "show.html", petition: petition)
  end

  def edit(conn, %{"id" => id}) do
    petition = Petitions.get_petition!(id)
    changeset = Petitions.change_petition(petition)
    render(conn, "edit.html", petition: petition, changeset: changeset)
  end

  def update(conn, %{"id" => id, "petition" => petition_params}) do
    petition = Petitions.get_petition!(id)

    case Petitions.update_petition(petition, petition_params) do
      {:ok, petition} ->
        conn
        |> put_flash(:info, "Petition updated successfully.")
        |> redirect(to: Routes.petition_path(conn, :show, petition))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", petition: petition, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    petition = Petitions.get_petition!(id)
    {:ok, _petition} = Petitions.delete_petition(petition)

    conn
    |> put_flash(:info, "Petition deleted successfully.")
    |> redirect(to: Routes.petition_path(conn, :index))
  end
end
