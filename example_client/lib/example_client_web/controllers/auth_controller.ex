defmodule ExampleClientWeb.AuthController do
  use ExampleClientWeb, :controller

  def callback(conn, params) do
    {:ok, claims} = Joken.verify(params["access_token"], Joken.Signer.parse_config(:public_key))

    case fetch_and_validate_resource(claims) do
      {:ok, resource} ->
        conn
        |> put_req_header("authorization", "Bearer #{params["access_token"]}")
        |> redirect(to: resource)

      {:error, _} ->
        conn
    end
  end

  defp fetch_and_validate_resource(claims) do
    with {:ok, scope} <- fetch_scope_from_claims(claims),
         {:ok, scope} <- check_scope_is_binary(scope),
         {:ok, resource} <- check_scope_is_valid_resource(scope) do
      {:ok, resource}
    end
  end

  defp fetch_scope_from_claims(claims) do
    case Map.fetch(claims, "scope") do
      {:ok, scope} -> {:ok, scope}
      _ -> {:error, :scope_missing}
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
