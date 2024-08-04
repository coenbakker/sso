defmodule ExampleClientWeb.AuthStrategy do
  use Assent.Strategy.OAuth2.Base

  @impl true
  def default_config(_config) do
    [
      base_url: "http://localhost:4000",
      authorize_url: "http://localhost:4000/oauth2/v1/auth",
      token_url: "/oauth2/v1/token",
      user_url: "/oauth2/v1/userinfo",
      auth_method: :client_secret_post
    ]
  end

  @impl true
  def normalize(_config, user) do
    {:ok,
      %{
        "sub"   => user["id"],
        "name"  => user["name"],
        "email" => user["email"]
      }
    }
  end
end
