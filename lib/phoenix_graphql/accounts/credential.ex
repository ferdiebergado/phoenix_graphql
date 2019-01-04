defmodule PhoenixGraphql.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  alias PhoenixGraphql.Accounts.User
  alias PhoenixGraphql.Encrypted.Binary
  alias PhoenixGraphql.Hashed.HMAC

  schema "credentials" do
    field :email, Binary
    field :email_hash, HMAC
    field :password, :string, virtual: true
    field :password_hash, :string
    field :facebook_app_id, Binary
    field :facebook_app_secret, Binary
    field :github_client_id, Binary
    field :github_client_secret, Binary
    field :google_client_id, Binary
    field :google_client_secret, Binary
    field :slack_client_id, Binary
    field :slack_client_secret, Binary
    field :twitter_consumer_key, Binary
    field :twitter_consumer_secret, Binary
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [
      :email,
      :password,
      :password_hash,
      :user_id,
      :facebook_app_id,
      :facebook_app_secret,
      :github_client_id,
      :github_client_secret,
      :google_client_id,
      :google_client_secret,
      :slack_client_id,
      :slack_client_secret,
      :twitter_consumer_key,
      :twitter_consumer_secret
    ])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8, max: 100)
    |> unique_constraint(:email, downcase: true)
    |> put_pass_hash()
    |> put_hashed_fields()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset

  defp put_hashed_fields(changeset) do
    changeset
    |> put_change(:email_hash, get_field(changeset, :email))
  end
end
