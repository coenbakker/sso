# defmodule IdpWeb.AuthController do
#   use IdpWeb, :controller

#   def authorize(conn, _params) do
#     # Check client_id and redirect_uri
#     #
#     # Check session for user_token
#     #   If user_token is present, validate it
#     #     If user_token is valid, redirect to /callback
#     #     If user_token is invalid, redirect to login page
#     #   If user_token is not present, redirect to login page
#     #
#     # Get requested scopes
#     # Sign scopes

#     conn
#     |> redirect(to: "/auth/v1/log_in")
#   end
# end
