defmodule ImmediateActWeb.PetitionControllerTest do
  use ImmediateActWeb.ConnCase

  alias ImmediateAct.Petitions

  @create_attrs %{description: "some description", due_date: "some due_date", goal: 120.5, title: "some title"}
  @update_attrs %{description: "some updated description", due_date: "some updated due_date", goal: 456.7, title: "some updated title"}
  @invalid_attrs %{description: nil, due_date: nil, goal: nil, title: nil}

  def fixture(:petition) do
    {:ok, petition} = Petitions.create_petition(@create_attrs)
    petition
  end

  describe "index" do
    test "lists all petitions", %{conn: conn} do
      conn = get(conn, Routes.petition_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Petitions"
    end
  end

  describe "new petition" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.petition_path(conn, :new))
      assert html_response(conn, 200) =~ "New Petition"
    end
  end

  describe "create petition" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.petition_path(conn, :create), petition: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.petition_path(conn, :show, id)

      conn = get(conn, Routes.petition_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Petition"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.petition_path(conn, :create), petition: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Petition"
    end
  end

  describe "edit petition" do
    setup [:create_petition]

    test "renders form for editing chosen petition", %{conn: conn, petition: petition} do
      conn = get(conn, Routes.petition_path(conn, :edit, petition))
      assert html_response(conn, 200) =~ "Edit Petition"
    end
  end

  describe "update petition" do
    setup [:create_petition]

    test "redirects when data is valid", %{conn: conn, petition: petition} do
      conn = put(conn, Routes.petition_path(conn, :update, petition), petition: @update_attrs)
      assert redirected_to(conn) == Routes.petition_path(conn, :show, petition)

      conn = get(conn, Routes.petition_path(conn, :show, petition))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, petition: petition} do
      conn = put(conn, Routes.petition_path(conn, :update, petition), petition: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Petition"
    end
  end

  describe "delete petition" do
    setup [:create_petition]

    test "deletes chosen petition", %{conn: conn, petition: petition} do
      conn = delete(conn, Routes.petition_path(conn, :delete, petition))
      assert redirected_to(conn) == Routes.petition_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.petition_path(conn, :show, petition))
      end
    end
  end

  defp create_petition(_) do
    petition = fixture(:petition)
    %{petition: petition}
  end
end
