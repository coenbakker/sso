defmodule ExampleClientWeb.AuthController do
  use ExampleClientWeb, :controller

  def callback(conn, params) do
    conn
    |> put_req_header("authorization", "Bearer #{params["access_token"]}")
    |> redirect(to: "/private")
  end
end
