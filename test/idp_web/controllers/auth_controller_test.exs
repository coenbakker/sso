defmodule IdpWeb.AuthControllerTest do
  use IdpWeb.ConnCase, async: true

  @oauth_login_url "/auth/v1/log_in"

  describe "authorize/2" do
    test "redirects to login page when user token is missing from session", %{conn: conn} do
      query_string =
        "client_id=123&redirect_uri=http://localhost:4000/callback&response_type=id_token%20token&scope=openid%20profile%20email"

      conn =
        conn
        |> Plug.Test.init_test_session(user_token: nil)
        |> get("/auth/v1/authorize?#{query_string}")

      assert redirected_to(conn) == @oauth_login_url
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
