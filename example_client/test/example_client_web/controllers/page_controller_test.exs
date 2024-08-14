defmodule ExampleClientWeb.PageControllerTest do
  use ExampleClientWeb.ConnCase, async: true
  alias ExampleClientWeb.JokenTestUtils

  @sso Application.compile_env(:example_client, :sso)
  @login_uri Keyword.get(@sso, :domain) <> Keyword.get(@sso, :endpoint)

  describe "public/2" do
    test "the public page is accessible without logging in", %{conn: conn} do
      conn = get(conn, "/")

      assert html_response(conn, 200) =~ "The Public Page"
    end
  end

  describe "private/2" do
    test "redirects to login page with signed access token when authorization header is missing",
         %{conn: conn} do
      conn = get(conn, "/private")
      assert @login_uri <> token = redirected_to(conn)
      assert String.length(token) > 0
    end

    test "grants access when authorization header is valid", %{conn: conn} do
      valid_access_token = JokenTestUtils.build_access_token!()

      conn =
        conn
        |> put_req_header("authorization", "Bearer #{valid_access_token}")
        |> get("/private")

      assert html_response(conn, 200) =~ "The Private Page"
    end

    test "redirects to login page with signed access token when authorization header is expired",
         %{conn: conn} do
      expired_access_token = JokenTestUtils.build_expired_access_token!()

      conn =
        conn
        |> put_req_header("authorization", "Bearer #{expired_access_token}")
        |> get("/private")

      assert @login_uri <> token = redirected_to(conn)
      assert String.length(token) > 0
    end

    test "redirects to login page with signed access token when authorization header is invalid",
         %{conn: conn} do
      invalid_access_token =
        "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MjQwNzQwMzYsImlhdCI6MTYyNDA3MzIzNiwiaXNzIjoiZXhhbXBsZV9jbGllbnQiLCJqdGkiOiJk"

      conn =
        conn
        |> put_req_header("authorization", "Bearer #{invalid_access_token}")
        |> get("/private")

      assert @login_uri <> token = redirected_to(conn)
      assert String.length(token) > 0
    end

    test "redirects to login page when scope does not match the request path", %{conn: conn} do
      valid_access_token = JokenTestUtils.build_access_token!("/public")

      conn =
        conn
        |> put_req_header("authorization", "Bearer #{valid_access_token}")
        |> get("/private")

      assert @login_uri <> token = redirected_to(conn)
      assert String.length(token) > 0
    end
  end
end
