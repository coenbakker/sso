defmodule IdpWeb.AuthTest do
  use Idp.DataCase, async: true
  import Idp.TestUtils
  alias Idp.Users.User
  alias IdpWeb.Auth

  @valid_password "Secret_Password_1234"
  @invalid_password "Too_Short"

  describe "valid_password?/2" do
    test "returns true for a valid password" do
      user = %User{password_hash: Bcrypt.hash_pwd_salt(@valid_password)}
      assert Auth.valid_password?(user, @valid_password)
    end

    test "returns false for an invalid password" do
      user = %User{password_hash: Bcrypt.hash_pwd_salt(@valid_password)}
      refute Auth.valid_password?(user, @invalid_password)
    end

    test "returns false for a missing user" do
      refute Auth.valid_password?(nil, @valid_password)
    end

    # IMPORTANT! This test alone is not sufficient to test for timing attack
    # vulnerabilities. This test only verifies whether the execution time in the
    # case that a user is missing is not much shorter than the other cases. If
    # this test fails it is likely that no counter measure was taken at all,
    # indicating a severe vulnerability.
    test "executing time when user is missing is not much smaller than other cases" do
      Task.async_stream(
        1..10,
        fn _ ->
          margin = 0.3

          valid_time =
            exec_time(fn -> %User{password_hash: Bcrypt.hash_pwd_salt(@valid_password)} end)

          invalid_time =
            exec_time(fn -> %User{password_hash: Bcrypt.hash_pwd_salt(@valid_password)} end)

          missing_time = exec_time(fn -> Auth.valid_password?(nil, @valid_password) end)

          assert missing_time > valid_time * margin
          assert missing_time > invalid_time * margin
        end,
        max_concurrency: 8
      )
      |> Stream.run()
    end
  end
end
