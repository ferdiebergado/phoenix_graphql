defmodule PhoenixGraphql.Hashed.HMAC do
  use Cloak.Ecto.HMAC, otp_app: :phoenix_graphql
end
