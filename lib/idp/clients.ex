defmodule Idp.Clients do
  import Ecto.Query, warn: false
  alias Idp.Repo
  alias Idp.Clients.Client

  def get_client_by_client_id(id) do
    Client
    |> where([c], c.client_id == ^id)
    |> Repo.one()
  end
end
