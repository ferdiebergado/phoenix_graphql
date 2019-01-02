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

  def create_user(_, attrs, _) do
    Accounts.create_user(attrs)
  end
end
