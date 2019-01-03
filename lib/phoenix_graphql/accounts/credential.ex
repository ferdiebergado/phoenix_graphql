defmodule PhoenixGraphql.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  alias PhoenixGraphql.Accounts.User

  schema "credentials" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
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
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
<<<<<<< Updated upstream
    |> cast(attrs, [:email, :password_hash])
=======
    |> cast(attrs, [
      :email,
      :password,
      :password_hash,
      :user_id,
      :FACEBOOK_APP_ID,
      :FACEBOOK_APP_SECRET,
      :GITHUB_CLIENT_ID,
      :GITHUB_CLIENT_SECRET,
      :GOOGLE_CLIENT_ID,
      :GOOGLE_CLIENT_SECRET,
      :SLACK_CLIENT_ID,
      :SLACK_CLIENT_SECRET,
      :TWITTER_CONSUMER_KEY,
      :TWITTER_CONSUMER_SECRET
    ])
>>>>>>> Stashed changes
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8, max: 100)
    |> unique_constraint(:email, downcase: true)
  end
end
