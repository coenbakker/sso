defmodule IdpWeb.Auth do
  @moduledoc """
  This module bundles functions for authenticating users.
  """

  alias Idp.Users.User

  @doc """
  Validates a user's password.

  Mitigates timing attacks by using Bcrypt.no_user_verify/0 when the user is not found.
  """
  @spec valid_password?(User.t(), String.t()) :: boolean()
  def valid_password?(%User{password_hash: password_hash} = user, password)
      when is_binary(password_hash) and byte_size(password) > 0 do
    Bcrypt.verify_pass(password, user.password_hash)
  end

  def valid_password?(_, _), do: Bcrypt.no_user_verify()
end
