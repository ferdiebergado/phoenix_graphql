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

  def create_user(attrs, %{context: %{current_user: _current_user}}) do
    Accounts.create_user(attrs)
  end

  def create_user(_args, _info) do
    {:error, "Not Authorized"}
  end
end
