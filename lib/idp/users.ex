defmodule Idp.Users do
  @moduledoc """
  Module responsible for exposing the context functions related to managing users.
  """

  import Ecto.Query, warn: false
  alias IdpWeb.Auth
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

  @doc """
  Returns a user with the given email and password, or nil if the user does not exist or the password is incorrect.
  """
  @spec get_user_by_email_and_password(String.t(), String.t()) :: User.t() | nil
  def get_user_by_email_and_password(email, password)
      when is_binary(email) and is_binary(password) do
    user = Repo.get_by(User, email: email)
    if Auth.valid_password?(user, password) do
      user
    end
  end
end
