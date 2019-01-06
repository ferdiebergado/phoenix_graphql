defmodule PhoenixGraphql.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias PhoenixGraphql.Accounts.Credential

  @timestamps_opts [type: :utc_datetime]

  schema "users" do
    field :firstname, :string
    field :lastname, :string
    field :username, :string, unique: true
    field :is_active, :boolean, default: false
    field :role, :integer, default: 1
    field :last_login, :utc_datetime
    field :token, :string, unique: true
    has_one(:credentials, Credential)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :username, :is_active, :last_login])
    |> validate_required([:firstname, :lastname, :username])
    |> unique_constraint(:username)
  end

  @doc false
  def store_token_changeset(user, attrs) do
    user
    |> cast(attrs, [:token])
    |> validate_required([:token])
    |> unique_constraint(:token)
  end

  @doc false
  def revoke_token_changeset(user, attrs) do
    user
    |> cast(attrs, [:token])
  end
end
