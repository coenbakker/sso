defmodule ExampleClientWeb.PublicLiveTest do
  use ExampleClientWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "public live" do
    test "renders without error", %{conn: conn} do
      {:ok, _, _} = live(conn, ~p"/")
    end

    test "renders the public page", %{conn: conn} do
      {:ok, _, html} = live(conn, ~p"/")
      assert html =~ "Public Page"
    end
  end
end
