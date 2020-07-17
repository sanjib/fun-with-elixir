defmodule LiveViewStudio.KinokuniyaStoresTest do
  use LiveViewStudio.DataCase

  alias LiveViewStudio.KinokuniyaStores

  describe "kinokuniya_stores" do
    alias LiveViewStudio.KinokuniyaStores.KinokuniyaStore

    @valid_attrs %{address1: "some address1", address2: "some address2", city: "some city", country: "some country", opening_hours: "some opening_hours", phone: "some phone", state: "some state", zip: "some zip"}
    @update_attrs %{address1: "some updated address1", address2: "some updated address2", city: "some updated city", country: "some updated country", opening_hours: "some updated opening_hours", phone: "some updated phone", state: "some updated state", zip: "some updated zip"}
    @invalid_attrs %{address1: nil, address2: nil, city: nil, country: nil, opening_hours: nil, phone: nil, state: nil, zip: nil}

    def kinokuniya_store_fixture(attrs \\ %{}) do
      {:ok, kinokuniya_store} =
        attrs
        |> Enum.into(@valid_attrs)
        |> KinokuniyaStores.create_kinokuniya_store()

      kinokuniya_store
    end

    test "list_kinokuniya_stores/0 returns all kinokuniya_stores" do
      kinokuniya_store = kinokuniya_store_fixture()
      assert KinokuniyaStores.list_kinokuniya_stores() == [kinokuniya_store]
    end

    test "get_kinokuniya_store!/1 returns the kinokuniya_store with given id" do
      kinokuniya_store = kinokuniya_store_fixture()
      assert KinokuniyaStores.get_kinokuniya_store!(kinokuniya_store.id) == kinokuniya_store
    end

    test "create_kinokuniya_store/1 with valid data creates a kinokuniya_store" do
      assert {:ok, %KinokuniyaStore{} = kinokuniya_store} = KinokuniyaStores.create_kinokuniya_store(@valid_attrs)
      assert kinokuniya_store.address1 == "some address1"
      assert kinokuniya_store.address2 == "some address2"
      assert kinokuniya_store.city == "some city"
      assert kinokuniya_store.country == "some country"
      assert kinokuniya_store.opening_hours == "some opening_hours"
      assert kinokuniya_store.phone == "some phone"
      assert kinokuniya_store.state == "some state"
      assert kinokuniya_store.zip == "some zip"
    end

    test "create_kinokuniya_store/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = KinokuniyaStores.create_kinokuniya_store(@invalid_attrs)
    end

    test "update_kinokuniya_store/2 with valid data updates the kinokuniya_store" do
      kinokuniya_store = kinokuniya_store_fixture()
      assert {:ok, %KinokuniyaStore{} = kinokuniya_store} = KinokuniyaStores.update_kinokuniya_store(kinokuniya_store, @update_attrs)
      assert kinokuniya_store.address1 == "some updated address1"
      assert kinokuniya_store.address2 == "some updated address2"
      assert kinokuniya_store.city == "some updated city"
      assert kinokuniya_store.country == "some updated country"
      assert kinokuniya_store.opening_hours == "some updated opening_hours"
      assert kinokuniya_store.phone == "some updated phone"
      assert kinokuniya_store.state == "some updated state"
      assert kinokuniya_store.zip == "some updated zip"
    end

    test "update_kinokuniya_store/2 with invalid data returns error changeset" do
      kinokuniya_store = kinokuniya_store_fixture()
      assert {:error, %Ecto.Changeset{}} = KinokuniyaStores.update_kinokuniya_store(kinokuniya_store, @invalid_attrs)
      assert kinokuniya_store == KinokuniyaStores.get_kinokuniya_store!(kinokuniya_store.id)
    end

    test "delete_kinokuniya_store/1 deletes the kinokuniya_store" do
      kinokuniya_store = kinokuniya_store_fixture()
      assert {:ok, %KinokuniyaStore{}} = KinokuniyaStores.delete_kinokuniya_store(kinokuniya_store)
      assert_raise Ecto.NoResultsError, fn -> KinokuniyaStores.get_kinokuniya_store!(kinokuniya_store.id) end
    end

    test "change_kinokuniya_store/1 returns a kinokuniya_store changeset" do
      kinokuniya_store = kinokuniya_store_fixture()
      assert %Ecto.Changeset{} = KinokuniyaStores.change_kinokuniya_store(kinokuniya_store)
    end
  end
end
