defmodule Idp.UsersTableTest do
  use Idp.DataCase
  alias Idp.Repo
  alias Idp.Accounts.User

  describe "users table" do
    test "unqiue email constraint" do
      email = "example@email.com"

      assert {:ok, _} = Repo.insert(%User{email: email, hashed_password: "some_hashed_password"})

      assert_raise Ecto.ConstraintError, fn ->
        Repo.insert(%User{email: email, hashed_password: "some_other_hashed_password"})
      end
    end
  end
end
