defmodule Idp.UsersTableTest do
  use Idp.DataCase
  alias Idp.Repo
  alias Idp.Users.User

  describe "users table" do
    test "unqiue email constraint" do
      email = "example@email.com"

      assert {:ok, _} = Repo.insert(%User{email: email, password_hash: "some_password_hash"})

      assert_raise Ecto.ConstraintError, fn ->
        Repo.insert(%User{email: email, password_hash: "some_other_password_hash"})
      end
    end
  end
end
