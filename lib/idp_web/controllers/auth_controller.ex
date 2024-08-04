defmodule IdpWeb.AuthController do
  use IdpWeb, :controller

  # TODO
  # Implement Authorization Code Flow with Proof Key for Code Exchange (PKCE)
  # https://auth0.com/docs/get-started/authentication-and-authorization-flow/authorization-code-flow-with-pkce

  def auth(conn, _params) do
    # TODO
    # Implement the authentication request
    conn
    |> redirect(external: "http://localhost:4001/auth/callback")
  end

  def token(conn, _params) do
    # TODO
    # This endpoint should only return an access token if the request contains a valid authorization code
    conn
    |> json(%{token: "token"})
  end

  def userinfo(conn, _params) do
    # TODO
    # This endpoint should only return the user information if the request contains a valid access token
    conn
    |> json(%{
      user: %{
        name: "John Doe",
        email: "jd@email.com",
        id: "123"
      }
    })
  end
end
