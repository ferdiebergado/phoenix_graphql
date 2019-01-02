defmodule PhoenixGraphqlWeb.Schema.Types do
  use Absinthe.Schema.Notation
  import_types(PhoenixGraphqlWeb.Schema.AccountsTypes)
  import_types(Absinthe.Type.Custom)
end
