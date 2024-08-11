defmodule IdpWeb.AuthController do
  use IdpWeb, :controller
  import Phoenix.Component, only: [to_form: 2]
  alias Idp.Clients

  @callback_url "http://localhost:4000/auth/v1/callback"
  @oauth_login_path "/auth/v1/log_in"
  @remember_me_cookie "_idp_web_user_remember_me"

  # TODO
  # Add tests for the controller
  # Implement missing functionality

  def authorize(conn, _params) do
    with {:ok, _} <- check_required_params(conn),
         {:ok, _} <- check_client_registration(conn),
         {:existing_user_token, conn} <- check_user_token(conn) do
      # TODO
      # Generate signed access token
      # Redirect to callback URL with access token
      redirect(conn, to: @callback_url)
    else
      {:no_user_token, conn} ->
        redirect(conn, to: @oauth_login_path)

      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: @oauth_login_path)
    end
  end

  def log_in(conn, _params) do
    render(conn, "log_in.html", %{form: to_form(%{}, as: "user")})
  end

  defp check_required_params(conn) do
    case conn.params do
      # TODO
      # Add all required parameters
      # Use @required_authorize_params module attribute
      %{"client_id" => _, "redirect_uri" => _} ->
        {:ok, conn}

      _ ->
        {:error, "Missing required parameters"}
    end
  end

  defp check_client_registration(conn) do
    client = Clients.get_client_by_id(conn.params["client_id"])

    if client && client.redirect_uri == conn.params["redirect_uri"] do
      {:ok, conn}
    else
      {:error, "Invalid client_id and/or redirect_uri"}
    end
  end

  defp check_user_token(conn) do
    if get_session(conn, :user_token) do
      {:existing_user_token, conn}
    else
      conn = fetch_cookies(conn, signed: [@remember_me_cookie])

      if token = conn.cookies[@remember_me_cookie] do
        {:existing_user_token, put_token_in_session(conn, token)}
      else
        {:no_user_token, conn}
      end
    end
  end

  defp put_token_in_session(conn, token) do
    conn
    |> put_session(:user_token, token)
    |> put_session(:live_socket_id, "users_sessions:#{Base.url_encode64(token)}")
  end
end
