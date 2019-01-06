defmodule PhoenixGraphql.Accounts.Credential do
  @moduledoc """
  The Credential Model
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias PhoenixGraphql.Accounts.User
  # alias PhoenixGraphql.Encrypted.Binary
  # alias PhoenixGraphql.Hashed.HMAC
  import Comeonin.Bcrypt, only: [add_hash: 1]

  @timestamps_opts [type: :utc_datetime]

  @required_fields ~w(
    email
    password
    )a

  @optional_fields ~w(
    id
    password_hash
    user_id
    facebook_app_id
    facebook_app_secret
    github_client_id
    github_client_secret
    google_client_id
    google_client_secret
    slack_client_id
    slack_client_secret
    twitter_consumer_key
    twitter_consumer_secret
    )a

  schema "credentials" do
    field :email, :string
    field :email_hash, :string
    field :password, :string, virtual: true
    field :password_hash, :string
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
    belongs_to(:user, User, foreign_key: :user_id)

    timestamps()
  end

  # For Cloak
  # schema "credentials" do
  #   field :email, :string
  #   field :email_hash, HMAC
  #   field :password, :string, virtual: true
  #   field :password_hash, :string
  #   field :facebook_app_id, :string
  #   field :facebook_app_secret, :string
  #   field :github_client_id, :string
  #   field :github_client_secret, :string
  #   field :google_client_id, :string
  #   field :google_client_secret, :string
  #   field :slack_client_id, :string
  #   field :slack_client_secret, :string
  #   field :twitter_consumer_key, :string
  #   field :twitter_consumer_secret, :string
  #   belongs_to(:user, User, foreign_key: :user_id)

  #   timestamps()
  # end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8, max: 100)
    |> unique_constraint(:email, downcase: true)
    |> put_pass_hash
    |> put_hashed_fields
  end

  @doc false
  def update_changeset(credential, attrs) do
    credential
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8, max: 100)
    |> unique_constraint(:email, downcase: true)
    |> put_pass_hash
    |> put_hashed_fields
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset

  defp put_hashed_fields(changeset) do
    changeset
    |> put_change(:email_hash, get_field(changeset, :email))
  end
end
