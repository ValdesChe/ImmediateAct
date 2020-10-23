defmodule ImmediateAct.PetitionsTest do
  use ImmediateAct.DataCase

  alias ImmediateAct.Petitions

  describe "petitions" do
    alias ImmediateAct.Petitions.Petition

    @valid_attrs %{description: "some description", due_date: "some due_date", goal: 120.5, title: "some title"}
    @update_attrs %{description: "some updated description", due_date: "some updated due_date", goal: 456.7, title: "some updated title"}
    @invalid_attrs %{description: nil, due_date: nil, goal: nil, title: nil}

    def petition_fixture(attrs \\ %{}) do
      {:ok, petition} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Petitions.create_petition()

      petition
    end

    test "list_petitions/0 returns all petitions" do
      petition = petition_fixture()
      assert Petitions.list_petitions() == [petition]
    end

    test "get_petition!/1 returns the petition with given id" do
      petition = petition_fixture()
      assert Petitions.get_petition!(petition.id) == petition
    end

    test "create_petition/1 with valid data creates a petition" do
      assert {:ok, %Petition{} = petition} = Petitions.create_petition(@valid_attrs)
      assert petition.description == "some description"
      assert petition.due_date == "some due_date"
      assert petition.goal == 120.5
      assert petition.title == "some title"
    end

    test "create_petition/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Petitions.create_petition(@invalid_attrs)
    end

    test "update_petition/2 with valid data updates the petition" do
      petition = petition_fixture()
      assert {:ok, %Petition{} = petition} = Petitions.update_petition(petition, @update_attrs)
      assert petition.description == "some updated description"
      assert petition.due_date == "some updated due_date"
      assert petition.goal == 456.7
      assert petition.title == "some updated title"
    end

    test "update_petition/2 with invalid data returns error changeset" do
      petition = petition_fixture()
      assert {:error, %Ecto.Changeset{}} = Petitions.update_petition(petition, @invalid_attrs)
      assert petition == Petitions.get_petition!(petition.id)
    end

    test "delete_petition/1 deletes the petition" do
      petition = petition_fixture()
      assert {:ok, %Petition{}} = Petitions.delete_petition(petition)
      assert_raise Ecto.NoResultsError, fn -> Petitions.get_petition!(petition.id) end
    end

    test "change_petition/1 returns a petition changeset" do
      petition = petition_fixture()
      assert %Ecto.Changeset{} = Petitions.change_petition(petition)
    end
  end
end
