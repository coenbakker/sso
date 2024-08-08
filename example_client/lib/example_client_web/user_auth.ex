defmodule ExampleClientWeb.UserAuth do
  use ExampleClientWeb, :verified_routes
  import Plug.Conn
  import Phoenix.Controller

  @sso Application.compile_env(:example_client, :sso)
  @login_uri Keyword.get(@sso, :domain) <> Keyword.get(@sso, :endpoint)

  def require_authenticated_user(conn, _opts) do
    if valid_access_token?(conn) do
      conn
    else
      conn
      |> redirect(external: @login_uri)
      |> halt()
    end
  end

  defp valid_access_token?(conn) do
    conn
    |> get_access_token()
    |> case do
      nil -> false
      access_token -> access_token == "replace_with_valid_access_token"
    end
  end

  defp get_access_token(conn) do
    case get_req_header(conn, "authorization") do
      [] ->
        nil

      header ->
        header
        |> List.first()
        |> String.split(" ")
        |> List.last()
    end
  end
end
