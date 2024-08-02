defmodule Idp.UserTest do
  use Idp.DataCase, async: true
  import Idp.TestUtils
  alias Idp.Users.User
  alias Idp.Repo

  @valid_attrs %{"email" => "user1234@example.com", "password" => "Secret_Password_1234"}
  @invalid_emails ["user", "user@", "user@ ", "user @example.com"]
  @invalid_passwords ["Too_Short", "missing_uppercase", "MISSING_LOWERCASE", "MissingDigitOrPunctuation"]

  %{"email" => "user1234", "password" => "too_short"}

  describe "user changeset" do
    test "with valid attributes" do
      changeset = User.changeset(%User{}, @valid_attrs)

      assert changeset.valid?
      assert changeset.changes.email == @valid_attrs["email"]
      assert changeset.changes.password_hash
    end

    test "with invalid email" do
      for email <- @invalid_emails do
        changeset =
          User.changeset(
            %User{},
            %{"email" => email, "password" => @valid_attrs["password"]}
          )

        if changeset.valid?, do: IO.puts("\n\nCulprit email: #{email}")
        refute changeset.valid?
        assert has_error?(changeset, :email)
      end
    end

    test "with invalid password" do
      for password <- @invalid_passwords do
        changeset =
          User.changeset(
            %User{},
            %{"email" => @valid_attrs["email"], "password" => password}
          )

        if changeset.valid?, do: IO.puts("\n\nCulprit password: #{password}")
        refute changeset.valid?
        assert has_error?(changeset, :password)
      end
    end

    test "with missing attributes" do
      changeset = User.changeset(%User{}, %{})

      refute changeset.valid?
      assert {:ok, {"can't be blank", _}} = get_error(changeset, :email)
      assert {:ok, {"can't be blank", _}} = get_error(changeset, :password)
    end

    test "password is hashed correctly" do
      changeset = User.changeset(%User{}, @valid_attrs)

      assert changeset.valid?
      assert changeset.changes.password_hash
      assert Bcrypt.verify_pass(@valid_attrs["password"], changeset.changes.password_hash)
    end

    test "unique email constraint" do
      %User{}
      |> User.changeset(@valid_attrs)
      |> Repo.insert!()

      assert {:error, changeset} = Repo.insert(User.changeset(%User{}, @valid_attrs))
      refute changeset.valid?
      assert {:ok, {"has already been taken", _}} = get_error(changeset, :email)
    end
  end
end
