defmodule ExampleClientWeb.AuthController do
  use ExampleClientWeb, :controller

  def callback(conn, params) do
    conn = fetch_session(conn)

    case fetch_and_validate_resource(conn) do
      {:ok, resource} ->
        conn
        |> put_req_header("authorization", "Bearer #{params["access_token"]}")
        |> redirect(to: resource)

      {:error, _} ->
        conn
        |> put_flash(
          :error,
          "Something went wrong while processing your request. Try again later."
        )
        |> redirect(to: "/")
    end
  end

  defp fetch_and_validate_resource(conn) do
    with {:ok, resource} <- fetch_return_to_resource(conn),
         {:ok, _} <- check_resource_exists(resource) do
      {:ok, resource}
    end
  end

  defp fetch_return_to_resource(conn) do
    conn
    |> get_session("return_to_resource")
    |> case do
      nil -> {:error, :return_to_resource_missing}
      resource -> {:ok, resource}
    end
  end

  defp check_resource_exists(resource) do
    case Phoenix.Router.route_info(ExampleClientWeb.Router, "GET", resource, "") do
      :error -> {:error, :resource_not_found}
      _ -> {:ok, resource}
    end
  end
end
