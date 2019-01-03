defmodule PhoenixGraphql.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :firstname, :string, null: false
      add :lastname, :string, null: false
      add :username, :string, null: false
      add :role, :integer, null: false
      add :is_active, :boolean, null: false
      add :last_login, :utc_datetime
      add :token, :text

      timestamps()
    end

    create unique_index(:users, [:username])
  end
end
