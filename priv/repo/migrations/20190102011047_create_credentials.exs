defmodule PhoenixGraphql.Repo.Migrations.CreateCredentials do
  use Ecto.Migration

  def change do
    create table(:credentials) do
      add :email, :binary, null: false
      add :password_hash, :string, null: false
      add :facebook_app_id, :binary
      add :facebook_app_secret, :binary
      add :github_client_id, :binary
      add :github_client_secret, :binary
      add :google_client_id, :binary
      add :google_client_secret, :binary
      add :slack_client_id, :binary
      add :slack_client_secret, :binary
      add :twitter_consumer_key, :binary
      add :twitter_consumer_secret, :binary
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:credentials, [
             :email,
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

    create index(:credentials, [:user_id])
  end
end
