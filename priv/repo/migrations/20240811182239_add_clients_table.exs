defmodule Idp.Repo.Migrations.AddClientsTable do
  use Ecto.Migration

  def change do
    create table(:clients, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :redirect_uri, :string, null: false

      timestamps()
    end

    create unique_index(:clients, [:id])
    create unique_index(:clients, [:id, :redirect_uri])
  end
end
