# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phoenix_graphql,
  ecto_repos: [PhoenixGraphql.Repo]

# Configures the endpoint
config :phoenix_graphql, PhoenixGraphqlWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MLbwAfFn2f3ZKf8yTl/eicN7Xo2BMm+xRg+B6M54jHRAxu3hNUXhqETRYgB8BxCv",
  render_errors: [view: PhoenixGraphqlWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: PhoenixGraphql.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# configures Guardian
config :phoenix_graphql, PhoenixGraphql.Accounts.Guardian,
  # optional
  allowed_algos: ["HS512"],
  # optional
  verify_module: Guardian.JWT,
  issuer: "Phoenix Graphql API by Ferdinand Saporas Bergado",
  ttl: {30, :days},
  allowed_drift: 2000,
  # optional
  verify_issuer: true,
  secret_key: "UZQunYXRflx4Ezd4w243i/myLExghrl5CbQHlN7cDVYEQcanfR6iBu8ODXRI/Zq6",
  serializer: PhoenixGraphql.Accounts.Guardian

config :phoenix_graphql, PhoenixGraphql.Hashed.HMAC,
  algorithm: :sha512,
  secret: "dbpKUNRHBNeEFfcMJAbiZMGEE7Pihf8be+cGC5E7ecg4NgbZ+UT2ZA6GRQdgeFm8"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
