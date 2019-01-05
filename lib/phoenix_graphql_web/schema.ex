defmodule PhoenixGraphqlWeb.Schema do
  use Absinthe.Schema
  import_types(PhoenixGraphqlWeb.Schema.Types)

  alias PhoenixGraphqlWeb.Resolvers.UserResolver
  alias PhoenixGraphqlWeb.Resolvers.CredentialResolver

  query do
    @desc "List all users"
    field :users, list_of(:user) do
      resolve(&UserResolver.list_users/3)
    end

    @desc "Find a user by ID"
    field :user, :user do
      arg(:id, non_null(:id))
      resolve(&UserResolver.find_user/3)
    end

    @desc "Authenticate a user"
    field :login, :token do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&CredentialResolver.login/3)
    end
  end

  mutation do
    @desc "Create a user"
    field :create_user, :user do
      arg(:firstname, non_null(:string))
      arg(:lastname, non_null(:string))
      arg(:username, non_null(:string))
      arg(:credentials, :accounts_input)
      resolve(&UserResolver.create_user/3)
    end

    @desc "Update a user"
    field :update_user, :user do
      arg(:id, non_null(:id))
      arg(:user, :update_user_input)

      resolve(&UserResolver.update_user/3)
    end

    @desc "Delete a user"
    field :delete_user, :user do
      arg(:id, non_null(:id))

      resolve(&UserResolver.delete_user/3)
    end

    @desc "Update a credential"
    field :update_credential, :credentials do
      arg(:id, non_null(:id))
      arg(:credentials, :update_credentials_input)

      resolve(&CredentialResolver.update_credential/3)
    end

    @desc "Logout user"
    field :logout, :user do
      # arg(:id, non_null(:id))
      resolve(&UserResolver.logout_user/3)
    end
  end
end
