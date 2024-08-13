defmodule IdpWeb.AuthController do
  use IdpWeb, :controller
  import Phoenix.Component, only: [to_form: 2]
  alias Idp.Clients

  @oauth_login_path "/auth/v1/log_in"
  @remember_me_cookie "_idp_web_user_remember_me"
  @required_authorize_params ~w(client_id redirect_uri)

  # TODO
  # Add tests for the controller
  # Implement missing functionality

  def authorize(conn, _params) do
    with {:ok, _} <- check_required_params(conn),
         {:ok, _} <- check_client_registration(conn),
         {:token_found, conn} <- check_user_token(conn) do
      # TODO
      # Generate signed access token
      # Redirect to callback URL with access token
      redirect(conn, external: conn.params["redirect_uri"])
    else
      {:token_not_found, conn} ->
        redirect(conn, to: @oauth_login_path)

      {:error, :unknown_client} ->
        conn
        |> put_status(:bad_request)
        |> put_view(IdpWeb.ErrorHTML)
        |> render(:invalid_registration, redirect_uri: conn.params["redirect_uri"])

      {:error, :missing_params} ->
        conn
        |> put_status(:bad_request)
        |> put_view(IdpWeb.ErrorHTML)
        |> render(:missing_authorize_params, redirect_uri: conn.params["redirect_uri"])
    end
  end

  def log_in(conn, _params) do
    render(conn, "log_in.html", %{form: to_form(%{}, as: "user")})
  end

  # TODO: Put private functions in a separate module
  defp check_required_params(conn) do
    if Enum.all?(@required_authorize_params, &Map.has_key?(conn.params, &1)) do
      {:ok, conn}
    else
      {:error, :missing_params}
    end
  end

  defp check_client_registration(conn) do
    client = Clients.get_client_by_client_id(conn.params["client_id"])

    if client && client.redirect_uri == conn.params["redirect_uri"] do
      {:ok, conn}
    else
      {:error, :unknown_client}
    end
  end

  defp check_user_token(conn) do
    if get_session(conn, :user_token) do
      {:token_found, conn}
    else
      conn = fetch_cookies(conn, signed: [@remember_me_cookie])

      if token = conn.cookies[@remember_me_cookie] do
        {:token_found, put_token_in_session(conn, token)}
      else
        {:token_not_found, conn}
      end
    end
  end

  defp put_token_in_session(conn, token) do
    conn
    |> put_session(:user_token, token)
    |> put_session(:live_socket_id, "users_sessions:#{Base.url_encode64(token)}")
  end
end
