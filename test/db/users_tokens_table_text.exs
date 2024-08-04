defmodule Idp.UsersTokensTableTest do
  use Idp.DataCase
  alias Idp.Repo
  alias Idp.Accounts.{User, UserToken}

  @email "example@email.com"
  @hashed_password "some_hashed_password"

  describe "users table" do
    test "unqiue email constraint" do
      {:ok, user} = Repo.insert(%User{email: @email, hashed_password: @hashed_password})

      user_token =
        %UserToken{
          user_id: user.id,
          token: "some_token",
          context: "session",
          sent_to: @email
        }

      assert {:ok, _} = Repo.insert(user_token)
      assert_raise Ecto.ConstraintError, fn -> Repo.insert(user_token) end
    end
  end
end
