defmodule Idp.Repo do
  use Ecto.Repo,
    otp_app: :idp,
    adapter: Ecto.Adapters.Postgres
end
