defmodule PhoenixGraphql.Repo.Migrations.CreateCredentials do
  use Ecto.Migration

  def change do
    create table(:credentials) do
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :FACEBOOK_APP_ID, :string
      add :FACEBOOK_APP_SECRET, :string
      add :GITHUB_CLIENT_ID, :string
      add :GITHUB_CLIENT_SECRET, :string
      add :GOOGLE_CLIENT_ID, :string
      add :GOOGLE_CLIENT_SECRET, :string
      add :SLACK_CLIENT_ID, :string
      add :SLACK_CLIENT_SECRET, :string
      add :TWITTER_CONSUMER_KEY, :string
      add :TWITTER_CONSUMER_SECRET, :string
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:credentials, [:email])
    create index(:credentials, [:user_id])
  end
end
