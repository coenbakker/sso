defmodule ExampleClient.Repo do
  use Ecto.Repo,
    otp_app: :example_client,
    adapter: Ecto.Adapters.Postgres
end
