defmodule PhoenixGraphqlWeb.Resolvers.UserResolver do
  alias PhoenixGraphql.Accounts

  def list_users(_, _, _) do
    {:ok, Accounts.list_users()}
  end

  def find_user(_, %{id: id}, _) do
    case Accounts.get_user(id) do
      nil -> {:error, "User #{id} does not exist."}
      user -> {:ok, user}
    end
  end

  def create_user(_, attrs, %{context: %{current_user: _current_user}}) do
    Accounts.create_user(attrs)
  end

  def create_user(_, _, _) do
    {:error, "Not Authorized"}
  end

  def update_user(_, %{id: id, user: user_params}, _) do
    # updates = %{user_params, %{credentials | user_id: id}}
    # cred_id = Accounts.get_credential_by_user_id(id)

    # updates = %{user_params.credentials | id: cred_id}

    case Accounts.get_user(id) do
      nil -> {:error, "User #{id} not found."}
      user -> user |> Accounts.update_user(user_params)
    end
  end
end
