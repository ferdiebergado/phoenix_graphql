defmodule PhoenixGraphql.Accounts.Login do
  @moduledoc false

  import Comeonin.Bcrypt, only: [checkpw: 2]
  alias PhoenixGraphql.Accounts

  def login_with_email_pass(email, given_pass) do
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
