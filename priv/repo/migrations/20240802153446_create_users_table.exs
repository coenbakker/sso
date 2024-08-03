defmodule Idp.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:users) do
      add :email, :citext, null: false
      add :password_hash, :string, null: false

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
