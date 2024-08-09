defmodule ExampleClientWeb.AuthControllerTest do
  use ExampleClientWeb.ConnCase, async: true
  import ExampleClientWeb.JokenTestUtils

  test "redirects to given resource path", %{conn: conn} do
    valid_access_token = build_access_token!("/private")
    conn = get(conn, "/callback?access_token=#{valid_access_token}")
    assert redirected_to(conn) == "/private"
  end

  test "puts the access token in a request header", %{conn: conn} do
    valid_access_token = build_access_token!("/private")

    conn =
      conn
      |> get("/callback?access_token=#{valid_access_token}")

    assert get_req_header(conn, "authorization") == ["Bearer #{valid_access_token}"]
  end
end
