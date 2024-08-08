defmodule ExampleClientWeb.PageController do
  use ExampleClientWeb, :controller

  def public(conn, _params), do: render(conn, "public.html")
  def private(conn, _params), do: render(conn, "private.html")
end
