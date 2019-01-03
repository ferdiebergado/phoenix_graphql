defmodule PhoenixGraphqlWeb.Schema.AccountsTypes do
  use Absinthe.Schema.Notation

  @desc "User"
  object :user do
    field :id, :id
    field :firstname, :string
    field :lastname, :string
    field :username, :string
    field :role, :integer
    field :is_active, :boolean
    field :last_login, :naive_datetime
    field :token, :string
    field :credentials, list_of(:credentials)
  end

  @desc "User credentials"
  object :credentials do
    field :email, :string
    field :facebook_app_id, :string
    field :github_client_id, :string
    field :google_client_id, :string
    field :slack_client_id, :string
    field :twitter_consumer_key, :string
  end

  input_object :accounts_input do
    field :email, non_null(:string)
    field :password, non_null(:string)
    field :facebook_app_id, :string
    field :facebook_app_secret, :string
    field :github_client_id, :string
    field :github_client_secret, :string
    field :google_client_id, :string
    field :google_client_secret, :string
    field :slack_client_id, :string
    field :slack_client_secret, :string
    field :twitter_consumer_key, :string
    field :twitter_consumer_secret, :string
  end

  object :token do
    field :token, :string
  end
end
