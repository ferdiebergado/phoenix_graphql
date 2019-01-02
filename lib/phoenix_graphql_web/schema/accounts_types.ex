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
    field :credential, list_of(:credential)
  end

  @desc "User credential/s"
  object :credential do
    field :email, :string
  end
end
