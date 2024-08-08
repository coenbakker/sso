defmodule ExampleClientWeb.PageControllerTest do
  use ExampleClientWeb.ConnCase, async: true

  @sso Application.compile_env(:example_client, :sso)
  @login_uri Keyword.get(@sso, :domain) <> Keyword.get(@sso, :endpoint)

  describe "public/2" do
    test "the public page is accessible without logging in", %{conn: conn} do
      conn = get(conn, "/")

      assert html_response(conn, 200) =~ "The Public Page"
    end
  end

  describe "private/2" do
    test "redirects to login page when user is not authenticated", %{conn: conn} do
      conn = get(conn, "/private")
      assert redirected_to(conn) == @login_uri
    end

    test "the private page is accessible when user is authenticated", %{conn: conn} do
      # TODO: Replace with a valid access token
      valid_access_token = "replace_with_valid_access_token"

      conn =
        conn
        |> put_req_header("authorization", "Bearer #{valid_access_token}")
        |> get("/private")

      assert html_response(conn, 200) =~ "The Private Page"
    end
  end
end
