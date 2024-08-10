defmodule IdpWeb.AuthController do
  use IdpWeb, :controller

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
end
