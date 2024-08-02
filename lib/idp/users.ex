defmodule Idp.Users do
  alias Idp.Repo
  alias Idp.Users.User

  @spec register_user(attrs :: map()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def register_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
