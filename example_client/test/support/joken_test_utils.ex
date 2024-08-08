defmodule ExampleClientWeb.JokenTestUtils do
  use Joken.Config

  def build_access_token!() do
    generate_and_sign!(
      %{
        "iss" => "example_client",
        "sub" => "user_id",
        "aud" => "example_client",
        "exp" => DateTime.utc_now() |> DateTime.add(10, :minute) |> DateTime.to_unix(),
        "nbf" => DateTime.utc_now() |> DateTime.to_unix(),
        "iat" => DateTime.utc_now() |> DateTime.to_unix(),
        "jti" => Joken.generate_jti()
      },
      :private_key
    )
  end

  def build_expired_access_token!() do
    generate_and_sign!(
      %{
        "iss" => "example_client",
        "sub" => "user_id",
        "aud" => "example_client",
        "exp" => DateTime.utc_now() |> DateTime.add(-10, :minute) |> DateTime.to_unix(),
        "nbf" => DateTime.utc_now() |> DateTime.add(-10, :minute) |> DateTime.to_unix(),
        "iat" => DateTime.utc_now() |> DateTime.add(-10, :minute) |> DateTime.to_unix(),
        "jti" => Joken.generate_jti()
      },
      :private_key
    )
  end

  def build_resource_token!(path) do
    generate_and_sign!(
      %{
        "iss" => "example_client",
        "sub" => "user_id",
        "aud" => "example_client",
        "exp" => DateTime.utc_now() |> DateTime.add(10, :minute) |> DateTime.to_unix(),
        "nbf" => DateTime.utc_now() |> DateTime.to_unix(),
        "iat" => DateTime.utc_now() |> DateTime.to_unix(),
        "jti" => Joken.generate_jti(),
        "resource" => path
      },
      :private_key
    )
  end
end
