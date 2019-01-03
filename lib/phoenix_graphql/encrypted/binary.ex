defmodule PhoenixGraphql.Encrypted.Binary do
  use Cloak.Ecto.Binary, vault: PhoenixGraphql.Vault
end
