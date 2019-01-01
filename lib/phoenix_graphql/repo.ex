defmodule PhoenixGraphql.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_graphql,
    adapter: Ecto.Adapters.Postgres
end
