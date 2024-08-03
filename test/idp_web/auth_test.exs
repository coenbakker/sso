defmodule IdpWeb.AuthTest do
  use Idp.DataCase, async: true
  import Idp.TestUtils
  alias Idp.Users.User
  alias IdpWeb.Auth

  @correct_password "Secret_Password_1234"
  @wrong_password "Wrong_Password_1234"

  describe "valid_password?/2" do
    test "returns true for a valid password" do
      user = %User{password_hash: Bcrypt.hash_pwd_salt(@correct_password)}
      assert Auth.valid_password?(user, @correct_password)
    end

    test "returns false for an invalid password" do
      user = %User{password_hash: Bcrypt.hash_pwd_salt(@correct_password)}
      refute Auth.valid_password?(user, @wrong_password)
    end

    test "returns false for a missing user" do
      refute Auth.valid_password?(nil, @correct_password)
    end

    # IMPORTANT! This test alone is not sufficient to test for timing attack
    # vulnerabilities. This test only verifies whether the execution time in the
    # case that a user is missing is not much shorter than the other cases. If
    # this test fails it is likely that no counter measure was taken at all,
    # indicating a severe vulnerability.
    test "executing time when user is missing is not much smaller than other cases" do
      margin = 0.3

      user = %User{password_hash: Bcrypt.hash_pwd_salt(@correct_password)}

      check_correct_pw = fn -> Auth.valid_password?(user, @correct_password) end
      check_wrong_pw = fn -> Auth.valid_password?(user, @wrong_password) end
      check_missing_pw = fn -> Auth.valid_password?(nil, @correct_password) end

      corret_pw_time = exec_time(check_correct_pw)
      wrong_pw_time = exec_time(check_wrong_pw)
      missing_pw_time = exec_time(check_missing_pw)

      assert missing_pw_time > corret_pw_time * margin
      assert missing_pw_time > wrong_pw_time * margin
    end
  end
end
