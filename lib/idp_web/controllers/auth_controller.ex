defmodule IdpWeb.AuthController do
  use IdpWeb, :controller

  def authorize(conn, _params) do
    # TODO: Implement the authorize action
    conn
    |> send_resp(200, "Authorize")
  end
end
