defmodule PhoenixGraphql.Accounts.Login do
  @moduledoc false

  import Comeonin.Argon2, only: [checkpw: 2]
  # alias PhoenixGraphql.Repo
  alias PhoenixGraphql.Accounts

  def login_with_email_pass(email, given_pass) do
    # user = Repo.get_by(User, credentials: %{email: String.downcase(email)})
    user = Accounts.get_user_by_email(email)

    cond do
      user && checkpw(given_pass, user.credentials.password_hash) ->
        {:ok, user}

      user ->
        {:error, "Incorrect login credentials"}

      true ->
        {:error, :"User not found"}
    end
  end
end
