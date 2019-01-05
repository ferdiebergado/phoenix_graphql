defmodule PhoenixGraphql.Utilities.EctoHelper do
  def get_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

  def output_graphql_format(changeset) do
    case changeset do
      {:ok, domain} -> {:ok, domain}
      {:error, changeset} -> {:error, %{message: get_errors(changeset)}}
    end
  end
end
