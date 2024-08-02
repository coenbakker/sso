defmodule Idp.UsersTest do
  use Idp.DataCase, async: true
  import Idp.TestUtils
  alias Idp.Users

  @valid_attrs %{"email" => "user1234@example.com", "password" => "Secret_Password_1234"}

  describe "register_user/1" do
    test "registers a user with valid attributes" do
      {:ok, user} = Users.register_user(@valid_attrs)

      assert user.email == @valid_attrs["email"]
      assert user.password_hash
    end

    test "does not register a user with invalid attributes" do
      {:error, changeset} = Users.register_user(%{})

      refute changeset.valid?
      assert has_error?(changeset, :email)
      assert has_error?(changeset, :password)
    end
  end
end
