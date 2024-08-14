defmodule ExampleClientWeb.AuthControllerTest do
  use ExampleClientWeb.ConnCase, async: true
  import ExampleClientWeb.JokenTestUtils

  test "redirects to requested resource", %{conn: conn} do
    valid_access_token = build_access_token!()

    conn =
      conn
      |> Plug.Test.init_test_session(%{"return_to_resource" => "/private"})
      |> get("/callback?access_token=#{valid_access_token}")

    assert redirected_to(conn) == "/private"
  end

  test "puts the access token in a request header", %{conn: conn} do
    valid_access_token = build_access_token!()

    conn =
      conn
      |> Plug.Test.init_test_session(%{"return_to_resource" => "/private"})
      |> get("/callback?access_token=#{valid_access_token}")

    assert get_req_header(conn, "authorization") == ["Bearer #{valid_access_token}"]
  end

  test "redirects to the root path if the resource does not exist", %{conn: conn} do
    valid_access_token = build_access_token!()

    conn =
      conn
      |> Plug.Test.init_test_session(%{"return_to_resource" => "/nonexistent"})
      |> get("/callback?access_token=#{valid_access_token}")

    assert redirected_to(conn) == "/"
  end

  test "redirects to the root path if the return_to_resource session key is missing", %{
    conn: conn
  } do
    valid_access_token = build_access_token!()
    conn = get(conn, "/callback?access_token=#{valid_access_token}")

    assert redirected_to(conn) == "/"
  end
end
