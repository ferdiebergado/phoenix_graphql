defmodule PhoenixGraphqlWeb.Resolvers.CredentialResolver do
  import PhoenixGraphql.Accounts.Login, only: [login_with_email_pass: 2]

  def login(%{email: email, password: password}, _info) do
    with {:ok, user} <- login_with_email_pass(email, password),
         {:ok, jwt, _} <- PhoenixGraphql.Accounts.Guardian.encode_and_sign(user),
         {:ok, _} <- PhoenixGraphql.Accounts.store_token(user, jwt) do
      {:ok, %{token: jwt}}
    end
  end
end
