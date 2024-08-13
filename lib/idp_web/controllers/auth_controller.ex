defmodule IdpWeb.AuthController do
  use IdpWeb, :controller
  import Phoenix.Component, only: [to_form: 2]
  # alias Idp.Clients

  @oauth_login_path "/auth/v1/log_in"
  @remember_me_cookie "_idp_web_user_remember_me"
  @required_authorize_params ~w(client_id redirect_uri)

  # TODO
  # Add tests for the controller
  # Implement missing functionality

  def authorize(conn, _params) do
    with {:ok, _} <- check_required_params(conn),
         {:ok, _} <- check_client_registration(conn),
         {:user_token_found, conn} <- check_user_token(conn) do
      # TODO
      # Generate signed access token
      # Redirect to callback URL with access token
      redirect(conn, to: conn.params["redirect_uri"])
    else
      {:user_token_not_found, conn} ->
        redirect(conn, to: @oauth_login_path)

      {:error, :invalid_client_registration} ->
        conn
        |> put_flash(:error, "Invalid client registration")
        |> put_status(:bad_request)
        |> put_view(IdpWeb.ErrorHTML)
        |> render(:invalid_oauth_registration)

      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> put_status(:bad_request)
        |> put_view(IdpWeb.ErrorHTML)
        |> render(:oauth_params_missing)
    end
  end

  def log_in(conn, _params) do
    render(conn, "log_in.html", %{form: to_form(%{}, as: "user")})
  end

  defp check_required_params(conn) do
    if Enum.all?(@required_authorize_params, &Map.has_key?(conn.params, &1)) do
      {:ok, conn}
    else
      {:error, "Missing required parameters"}
    end
  end

  defp check_client_registration(conn) do
    # client = Clients.get_client_by_id(conn.params["client_id"])
    client = nil

    if client && client.redirect_uri == conn.params["redirect_uri"] do
      {:ok, conn}
    else
      {:error, :invalid_client_registration}
    end
  end

  defp check_user_token(conn) do
    if get_session(conn, :user_token) do
      {:user_token_found, conn}
    else
      conn = fetch_cookies(conn, signed: [@remember_me_cookie])

      if token = conn.cookies[@remember_me_cookie] do
        {:user_token_found, put_token_in_session(conn, token)}
      else
        {:user_token_not_found, conn}
      end
    end
  end

  defp put_token_in_session(conn, token) do
    conn
    |> put_session(:user_token, token)
    |> put_session(:live_socket_id, "users_sessions:#{Base.url_encode64(token)}")
  end
end
