defmodule PhoenixGraphqlWeb.Router do
  use PhoenixGraphqlWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PhoenixGraphqlWeb do
    pipe_through :api
  end
end
