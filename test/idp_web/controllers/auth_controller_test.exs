defmodule IdpWeb.AuthControllerTest do
  use IdpWeb.ConnCase, async: true

  @oauth_login_url "/auth/v1/log_in"

  describe "authorize/2" do
    test "redirects to login page when user token is missing from session", %{conn: conn} do
      query_string = "client_id=123&redirect_uri=http://localhost:4000/callback&response_type=id_token%20token&scope=openid%20profile%20email"

      conn =
        conn
        |> Plug.Test.init_test_session(user_token: nil)
        |> get("/auth/v1/authorize?#{query_string}")

      assert redirected_to(conn) == @oauth_login_url
    end
  end
end
