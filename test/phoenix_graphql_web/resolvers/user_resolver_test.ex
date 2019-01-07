defmodule PhoenixGraphqlWeb.Resolvers.UserResolverTest do
  use PhoenixGraphqlWeb.ConnCase
  alias PhoenixGraphql.Accounts

  test "find_user/3 returns a user with the given id" do
    users = [
      %{
        username: "lazyJohn",
        firstname: "jhon",
        lastname: "lazy",
        credentials: %{email: "john@example.com", password: "johnpass"}
      },
      %{
        username: "Jane",
        firstname: "jane",
        lastname: "doe",
        credentials: %{email: "jane@example.com", password: "janepass"}
      }
    ]

    # create users local to this database connection and test
    [{:ok, user1}, {:ok, user2}] = Enum.map(users, &Accounts.create_user(&1))

    query = """
    {
      user(id: #{user1.id}) {
        id
        username
        credentials {
          email
        }
      }
    }
    """

    res =
      conn
      |> post("/api/graphql", %{query: query})
      |> json_response(200)

    assert res == %{
             "data" => %{
               "user" => %{
                 "id" => to_string(user1.id),
                 "username" => user1.username,
                 "credentials" => [%{"email" => user1.credentials.email}]
               }
             }
           }
  end
end
