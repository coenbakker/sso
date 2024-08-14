defmodule Idp.Clients.Client do
  use Ecto.Schema

  schema "clients" do
    field :client_id, :string
    field :redirect_uri, :string

    timestamps()
  end
end
