defmodule Idp.AuthControllerTest do
  use IdpWeb.ConnCase, async: true

  describe "POST authorize/2" do
    test "returns 200", %{conn: conn} do
      conn = post(conn, "/authorize")
      assert response(conn, 200)
    end
  end

  describe "GET authorize/2" do
    test "returns 200", %{conn: conn} do
      conn = get(conn, "/authorize")
      assert response(conn, 200)
    end
  end
end
