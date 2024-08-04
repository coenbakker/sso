defmodule ExampleClientWeb.SecretLiveTest do
  use ExampleClientWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "public live" do
    test "renders without error", %{conn: conn} do
      {:ok, _, _} = live(conn, ~p"/secret")
    end

    test "renders the public page", %{conn: conn} do
      {:ok, _, html} = live(conn, ~p"/secret")
      assert html =~ "Secret Page"
    end
  end
end
