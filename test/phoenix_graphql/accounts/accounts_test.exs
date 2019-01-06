defmodule PhoenixGraphql.AccountsTest do
  use PhoenixGraphql.DataCase

  alias PhoenixGraphql.Accounts

  describe "users" do
    alias PhoenixGraphql.Accounts.User
    alias PhoenixGraphql.Accounts.Credential
    import Comeonin.Bcrypt, only: [checkpw: 2]

    @valid_attrs %{
      firstname: "some firstname",
      lastname: "some lastname",
      username: "some username",
      credentials: %{
        email: "some@email.com",
        password: "somepassword"
      }
    }
    @update_attrs %{
      firstname: "some updated firstname",
      lastname: "some updated lastname",
      username: "some updated username",
      credentials: %{
        email: "someupdated@email.com",
        password: "someupdatedpassword"
      }
    }
    @invalid_attrs %{
      firstname: nil,
      lastname: nil,
      username: nil,
      credentials: %{
        email: "notanemail",
        password: "only5"
      }
    }

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.firstname == "some firstname"
      assert user.lastname == "some lastname"
      assert user.username == "some username"
      assert user.credentials.email == "some@email.com"
      assert true == checkpw("somepassword", user.credentials.password_hash)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.firstname == "some updated firstname"
      assert user.lastname == "some updated lastname"
      assert user.username == "some updated username"
      assert user.credentials.email == "someupdated@email.com"
      assert true == checkpw("someupdatedpassword", user.credentials.password_hash)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      # assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)

      assert {:error,
              %{
                message: %{
                  firstname: ["can't be blank"],
                  lastname: ["can't be blank"],
                  username: ["can't be blank"],
                  credentials: %{
                    email: ["has invalid format"],
                    password: ["should be at least 8 character(s)"]
                  }
                }
              }} = Accounts.update_user(user, @invalid_attrs)

      assert user == Accounts.get_user(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      # assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
      assert is_nil(Accounts.get_user(user.id))
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  # describe "credentials" do
  #   alias PhoenixGraphql.Accounts.Credential

  #   @valid_attrs %{email: "test@example.com", password: "some password", user_id: 1}
  #   @update_attrs %{email: "email@domain.com", password: "new password", user_id: 1}
  #   @invalid_attrs %{email: nil, password: nil, user_id: nil}

  #   def credential_fixture(attrs \\ %{}) do
  #     {:ok, credential} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Accounts.create_credential()

  #     credential
  #   end

  #   test "list_credentials/0 returns all credentials" do
  #     credential = credential_fixture()
  #     assert Accounts.list_credentials() == [credential]
  #   end

  #   test "get_credential!/1 returns the credential with given id" do
  #     credential = credential_fixture()
  #     assert Accounts.get_credential!(credential.id) == credential
  #   end

  #   test "create_credential/1 with valid data creates a credential" do
  #     assert {:ok, %Credential{} = credential} = Accounts.create_credential(@valid_attrs)
  #     assert credential.email == "some email"
  #   end

  #   test "create_credential/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Accounts.create_credential(@invalid_attrs)
  #   end

  #   test "update_credential/2 with valid data updates the credential" do
  #     credential = credential_fixture()

  #     assert {:ok, %Credential{} = credential} =
  #              Accounts.update_credential(credential, @update_attrs)

  #     assert credential.email == "some updated email"
  #   end

  #   test "update_credential/2 with invalid data returns error changeset" do
  #     credential = credential_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Accounts.update_credential(credential, @invalid_attrs)
  #     assert credential == Accounts.get_credential!(credential.id)
  #   end

  #   test "delete_credential/1 deletes the credential" do
  #     credential = credential_fixture()
  #     assert {:ok, %Credential{}} = Accounts.delete_credential(credential)
  #     assert_raise Ecto.NoResultsError, fn -> Accounts.get_credential!(credential.id) end
  #   end

  #   test "change_credential/1 returns a credential changeset" do
  #     credential = credential_fixture()
  #     assert %Ecto.Changeset{} = Accounts.change_credential(credential)
  #   end
  # end
end
