defmodule Idp.Users do
  @moduledoc """
  Module responsible for exposing the context functions related to managing users.
  """

  alias Idp.Repo
  alias Idp.Users.User

  @doc """
  Registers a user with the given attributes.
  """
  @spec register_user(attrs :: map()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def register_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
