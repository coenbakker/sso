defmodule ExampleClientWeb.AuthController do
  use ExampleClientWeb, :controller
  alias ExampleClientWeb.Auth

  def request(conn, _params), do: Auth.request(conn)
  def callback(conn, _params), do: Auth.callback(conn)
end
