defmodule Idp.UsersTest do
  use Idp.DataCase, async: true
  import Idp.TestUtils
  alias Idp.Users
  alias Idp.Users.User

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

  describe "get_user_by_email_and_password/2" do
    test "returns a user when the email and password match" do
      {:ok, %{id: id}} = Users.register_user(@valid_attrs)

      assert %User{id: ^id} =
               Users.get_user_by_email_and_password(
                 @valid_attrs["email"],
                 @valid_attrs["password"]
               )
    end

    test "returns nil when the email and password do not match" do
      {:ok, _} = Users.register_user(@valid_attrs)

      assert nil ==
               Users.get_user_by_email_and_password(
                 @valid_attrs["email"],
                 "wrong_password"
               )
    end

    test "returns nil when the email does not exist" do
      assert nil ==
               Users.get_user_by_email_and_password(
                 "some_other@email.com",
                 "some_other_password"
               )
    end
  end
end
