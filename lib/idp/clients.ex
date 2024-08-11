defmodule Idp.Clients do
  alias Idp.Repo
  alias Idp.Clients.Client

  def get_client_by_id(id) do
    Repo.get(Client, id)
  end
end
