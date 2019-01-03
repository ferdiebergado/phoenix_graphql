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
    field :credentials, list_of(:credentials)
  end

  @desc "User credentials"
  object :credentials do
    field :email, :string
    field :FACEBOOK_APP_ID, :string
    field :GITHUB_CLIENT_ID, :string
    field :GOOGLE_CLIENT_ID, :string
    field :SLACK_CLIENT_ID, :string
    field :TWITTER_CONSUMER_KEY, :string
  end

  input_object :accounts_input do
    field :email, non_null(:string)
    field :password, non_null(:string)
    field :FACEBOOK_APP_ID, :string
    field :FACEBOOK_APP_SECRET, :string
    field :GITHUB_CLIENT_ID, :string
    field :GITHUB_CLIENT_SECRET, :string
    field :GOOGLE_CLIENT_ID, :string
    field :GOOGLE_CLIENT_SECRET, :string
    field :SLACK_CLIENT_ID, :string
    field :SLACK_CLIENT_SECRET, :string
    field :TWITTER_CONSUMER_KEY, :string
    field :TWITTER_CONSUMER_SECRET, :string
  end
end
