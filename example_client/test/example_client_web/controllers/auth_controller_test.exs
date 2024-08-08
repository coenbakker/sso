defmodule ExampleClientWeb.AuthControllerTest do
  use ExampleClientWeb.ConnCase, async: true
  alias ExampleClientWeb.JokenTestUtils

  @sso Application.compile_env(:example_client, :sso)
  @login_uri Keyword.get(@sso, :domain) <> Keyword.get(@sso, :endpoint)

  test "valid access token grants access to /private", %{conn: conn} do
    valid_access_token = JokenTestUtils.build_access_token!()
    valid_resource_token = JokenTestUtils.build_resource_token!("/private")

    conn =
      get(conn, "/callback?access_token=#{valid_access_token}&resource=#{valid_resource_token}")

    assert "/private" = redir_path = redirected_to(conn)

    conn = get(recycle(conn), redir_path)
    assert html_response(conn, 200) =~ "The Private Page"
  end

  test "invalid access token redirects to SSO login endpoint", %{conn: conn} do
    valid_resource_token = JokenTestUtils.build_resource_token!("/private")

    conn =
      get(conn, "/callback?access_token=invalid_access_token&resource=#{valid_resource_token}")

    assert "/private" = redir_path = redirected_to(conn)

    conn = get(recycle(conn), redir_path)
    assert redirected_to(conn) == @login_uri
  end
end
