defmodule Idp.Repo.Migrations.AddClientsTable do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :client_id, :string, null: false
      add :redirect_uri, :string, null: false

      timestamps()
    end

    create unique_index(:clients, [:client_id])
    create unique_index(:clients, [:client_id, :redirect_uri])
  end
end
