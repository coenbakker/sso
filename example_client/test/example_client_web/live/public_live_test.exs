defmodule ExampleClientWeb.PublicLiveTest do
  use ExampleClientWeb.ConnCase, async: true

  test "the public page is accessible without logging in", %{conn: conn} do
    conn = get(conn, "/")

    assert html_response(conn, 200) =~ "The Public Page"
  end
end
