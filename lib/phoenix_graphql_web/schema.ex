defmodule PhoenixGraphqlWeb.Schema do
  use Absinthe.Schema

  import_types(PhoenixGraphqlWeb.Schema.Types)

  alias PhoenixGraphqlWeb.Resolvers

  query do
    @desc "List all users"
    field :users, list_of(:user) do
      resolve(&Resolvers.UserResolver.list_users/3)
    end

    @desc "Find a user by ID"
    field :user, :user do
      arg(:id, non_null(:id))
      resolve(&Resolvers.UserResolver.find_user/3)
    end
  end

  mutation do
    @desc "Create a user"
    field :create_user, :user do
      arg(:firstname, non_null(:string))
      arg(:lastname, non_null(:string))
      arg(:username, non_null(:string))
      arg(:credentials, :accounts_input)
      resolve(&Resolvers.UserResolver.create_user/2)
    end
  end
end
