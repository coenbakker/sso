defmodule ExampleClientWeb.AuthControllerTest do
  use ExampleClientWeb.ConnCase, async: true
  import ExampleClientWeb.JokenTestUtils

  test "redirects to given resource path", %{conn: conn} do
    valid_resource_token = build_resource_token!("/private")
    conn = get(conn, "/callback?access_token=token&resource=#{valid_resource_token}")
    assert redirected_to(conn) == "/private"

    valid_resource_token = build_resource_token!("/other-path")
    conn = get(conn, "/callback?access_token=token&resource=#{valid_resource_token}")
    assert redirected_to(conn) == "/other-path"
  end

  test "puts the access token in a request header", %{conn: conn} do
    valid_access_token = build_access_token!()
    valid_resource_token = build_resource_token!("/private")

    conn =
      conn
      |> get("/callback?access_token=#{valid_access_token}&resource=#{valid_resource_token}")

    assert get_req_header(conn, "authorization") == ["Bearer #{valid_access_token}"]
  end
end
