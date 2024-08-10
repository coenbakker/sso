defmodule ExampleClientWeb.AuthController do
  use ExampleClientWeb, :controller

  def callback(conn, params) do
    conn = Plug.Conn.fetch_session(conn)

    case fetch_and_validate_resource(conn) do
      {:ok, resource} ->
        conn
        |> put_req_header("authorization", "Bearer #{params["access_token"]}")
        |> redirect(to: resource)

      {:error, _} ->
        conn
    end
  end

  defp fetch_return_to_resource(conn) do
    conn
    |> Plug.Conn.get_session("return_to_resource")
    |> case do
      nil -> {:error, :return_to_resource_missing}
      resource -> {:ok, resource}
    end
  end

  defp fetch_and_validate_resource(conn) do
    with {:ok, resource} <- fetch_return_to_resource(conn),
         {:ok, _} <- check_scope_is_binary(resource),
         {:ok, _} <- check_scope_is_valid_resource(resource) do
      {:ok, resource}
    end
  end

  defp check_scope_is_binary(scope) do
    case is_binary(scope) do
      true -> {:ok, scope}
      false -> {:error, :scope_invalid}
    end
  end

  defp check_scope_is_valid_resource(scope) do
    with {:ok, scope} <- check_one_scope_only(scope),
         {:ok, _} <- check_path_exists(scope) do
      {:ok, scope}
    end
  end

  defp check_one_scope_only(scope) do
    case String.split(scope, " ") do
      [scope] -> {:ok, scope}
      _ -> {:error, :scope_invalid}
    end
  end

  defp check_path_exists(path) do
    case Phoenix.Router.route_info(ExampleClientWeb.Router, "GET", path, "") do
      :error -> {:error, :resource_not_found}
      _ -> {:ok, path}
    end
  end
end
