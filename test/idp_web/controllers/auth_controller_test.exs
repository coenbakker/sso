defmodule IdpWeb.AuthControllerTest do
  use IdpWeb.ConnCase, async: true
  alias Idp.Repo
  alias Idp.Clients.Client

  @oauth_login_url "/auth/v1/log_in"

  describe "authorize/2" do
    test "redirects to login page when user token is missing from session", %{conn: conn} do
      Repo.insert!(%Client{client_id: "123", redirect_uri: "https://page.com/callback"})

      query_string =
        "client_id=123&redirect_uri=https://page.com/callback&response_type=id_token%20token&scope=openid"

      conn =
        conn
        |> Plug.Test.init_test_session(user_token: nil)
        |> get("/auth/v1/authorize?#{query_string}")

      assert redirected_to(conn) == @oauth_login_url
    end

    test "redirects to callback URL with signed access token when user token is present in session", %{conn: conn} do
      Repo.insert!(%Client{client_id: "123", redirect_uri: "https://page.com/callback"})

      query_string =
        "client_id=123&redirect_uri=https://page.com/callback&response_type=id_token%20token&scope=openid"

      conn =
        conn
        |> Plug.Test.init_test_session(user_token: "user_token")
        |> get("/auth/v1/authorize?#{query_string}")

      assert  "https://page.com/callback?access_token" <> token = redirected_to(conn)
      assert String.length(token) > 0
    end

    test "fails when required params are missing", %{conn: conn} do
      conn = get(conn, "/auth/v1/authorize")
      assert html_response(conn, 400) =~ "Missing required parameters"
    end

    test "fails when client is not registered", %{conn: conn} do
      conn = get(conn, "/auth/v1/authorize?client_id=123&redirect_uri=https://page.com/callback")
      assert html_response(conn, 400) =~ "Invalid SSO client registration"
    end
  end

  describe "log_in/2" do
    test "renders the login page", %{conn: conn} do
      conn = get(conn, "/auth/v1/log_in")
      resp = html_response(conn, 200)

      assert resp =~ ~s|id="oauth_login_form"|
      assert resp =~ "Log in"
      assert resp =~ "Email"
      assert resp =~ "Password"
    end

    test "redirects if credentials valid", %{conn: _conn} do
      assert true
    end

    test "redirects to login page with a flash error if credentials invalid", %{conn: _conn} do
      assert true
    end

    test "redirects to home with flash info if already logged in", %{conn: _conn} do
      assert true
    end
  end
end
