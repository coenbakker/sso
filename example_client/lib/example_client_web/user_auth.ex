defmodule ExampleClientWeb.UserAuth do
  use ExampleClientWeb, :verified_routes
  import Plug.Conn
  import Phoenix.Controller

  @sso Application.compile_env(:example_client, :sso)
  @login_uri Keyword.get(@sso, :domain) <> Keyword.get(@sso, :endpoint)
  @public_key struct(Joken.Signer, Keyword.get(@sso, :public_key))

  def require_authenticated_user(conn, _opts) do
    if valid_access_token_in_header?(conn) do
      conn
    else
      conn
      |> redirect(external: @login_uri)
      |> halt()
    end
  end

  defp valid_access_token_in_header?(conn) do
    conn
    |> get_access_token_from_header()
    |> case do
      nil -> false
      access_token -> valid_access_token?(access_token)
    end
  end

  defp get_access_token_from_header(conn) do
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

  defp valid_access_token?(access_token) do
    with {:ok, claims} <- Joken.verify(access_token, @public_key),
         {:ok, exp} <- fetch_expiration_claim(claims),
         {:ok, _} <- check_access_token_not_expired(exp) do
      true
    else
      _ -> false
    end
  end

  defp fetch_expiration_claim(claims) do
    case Map.get(claims, "exp") do
      nil -> {:error, "expiration claim not found"}
      exp -> {:ok, exp}
    end
  end

  defp check_access_token_not_expired(exp) do
    now = DateTime.utc_now() |> DateTime.to_unix()

    if exp < now do
      {:error, "token expired"}
    else
      {:ok, "token not expired"}
    end
  end
end
