defmodule PhoenixGraphqlWeb.Resolvers.UserResolver do
  alias PhoenixGraphql.Accounts

  def list_users(_, _, _) do
    {:ok, Accounts.list_users()}
  end

  def find_user(id) do
    case Accounts.get_user(id) do
      nil -> {:error, "User #{id} does not exist."}
      user -> {:ok, user}
    end
  end

  def create_user(attrs, %{context: %{current_user: _current_user}}) do
    Accounts.create_user(attrs)
  end

  def create_user(_args, _info) do
    {:error, "Not Authorized"}
  end

  def update_user(%{id: id, user: user_params}, _info) do
    case find_user(id) do
      {:ok, user} -> user |> Accounts.update_user(user_params)
      {:error, error} -> error
    end
  end
end
