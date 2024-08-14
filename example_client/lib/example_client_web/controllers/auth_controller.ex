defmodule ExampleClientWeb.AuthController do
  use ExampleClientWeb, :controller

  # TODO: Handle failed authentication
  def callback(conn, params) do
    {:ok, claims} = Joken.verify(params["resource"], Joken.Signer.parse_config(:public_key))

    conn
    |> put_req_header("authorization", "Bearer #{params["access_token"]}")
    |> redirect(to: claims["resource"])
  end
end
