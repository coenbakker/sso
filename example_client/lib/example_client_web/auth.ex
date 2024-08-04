defmodule ExampleClientWeb.Auth do
  import Plug.Conn
  alias Assent.Config
  alias ExampleClientWeb.AuthStrategy

  @config [
    client_id: "REPLACE_WITH_CLIENT_ID",
    client_secret: "REPLACE_WITH_CLIENT_SECRET",
    redirect_uri: "http://localhost:4000/auth/callback"
  ]

  # http://localhost:4000/auth/
  def request(conn) do
    @config
    |> AuthStrategy.authorize_url()
    |> case do
      {:ok, %{url: url, session_params: session_params}} ->
        # Session params (used for OAuth 2.0 and OIDC strategies) will be
        # retrieved when user returns for the callback phase
        conn = put_session(conn, :session_params, session_params)

        # Redirect end-user to IdP to authorize access to their account
        conn
        |> put_resp_header("location", url)
        |> send_resp(302, "")

      {:error, error} ->
        IO.inspect(error)
        # Something went wrong generating the request authorization url
    end
  end

  # http://localhost:4000/auth/callback
  def callback(conn) do
    # End-user will return to the callback URL with params attached to the
    # request. These must be passed on to the strategy. In this example we only
    # expect GET query params, but the provider could also return the user with
    # a POST request where the params is in the POST body.
    %{params: params} = fetch_query_params(conn)

    # The session params (used for OAuth 2.0 and OIDC strategies) stored in the
    # request phase will be used in the callback phase
    session_params = get_session(conn, :session_params)

    @config
    # Session params should be added to the config so the strategy can use them
    |> Config.put(:session_params, session_params)
    |> AuthStrategy.callback(params)
    |> case do
      {:ok, %{user: user, token: token}} ->
        IO.inspect(user)
        IO.inspect(token)
        # Authorization succesful

      {:error, error} ->
        IO.inspect(error)
        # Authorizaiton failed
    end
  end
end
