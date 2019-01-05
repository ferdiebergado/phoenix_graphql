defmodule PhoenixGraphqlWeb.Resolvers.CredentialResolver do
  import PhoenixGraphql.Accounts.Login, only: [login_with_email_pass: 2]
  alias PhoenixGraphql.Accounts

  def login(_, %{email: email, password: password}, _) do
    with {:ok, user} <- login_with_email_pass(email, password),
         {:ok, jwt, _} <- PhoenixGraphql.Accounts.Guardian.encode_and_sign(user),
         {:ok, _} <- PhoenixGraphql.Accounts.store_token(user, jwt) do
      {:ok, %{token: jwt}}
    end
  end

  def update_credential(_, %{id: id, credentials: params}, _) do
    case Accounts.get_credential(id) do
      nil ->
        {:error, "Credential with ID #{id} not found."}

      credential ->
        credential
        |> Accounts.update_credential(params)
    end
  end
end
