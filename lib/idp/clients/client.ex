defmodule Idb.Clients.Client do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: true}

  schema "clients" do
    field :redirect_uri, :string

    timestamps()
  end
end
