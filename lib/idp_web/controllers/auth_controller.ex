defmodule IdpWeb.AuthController do
  use IdpWeb, :controller
  import Phoenix.Component, only: [to_form: 2]

  @oauth_login_url "/auth/v1/log_in"

  # TODO: Continue here

  def authorize(conn, _params) do
    # WITH
    # Validate required parameters
    # Validate client_id registration
    # Validate redirect_uri registration
    # Check for existing session using user_token
    #
    # DO
    # Make GET request to /auth/v1/authorize
    #
    # ELSE
    # Redirect to /auth/v1/log_in

    conn
    |> redirect(to: @oauth_login_url)
  end

  def log_in(conn, _params) do
    conn
    |> render("log_in.html", %{form: to_form(%{}, as: "user")})
  end
end
