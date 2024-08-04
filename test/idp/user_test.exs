defmodule Idp.UserTest do
  use Idp.DataCase, async: true
  import Idp.TestUtils
  alias Idp.Accounts.User

  # IMPORTANT! This test alone is not sufficient to test for timing attack
  # vulnerabilities. This test only verifies whether the execution time in the
  # case that a user is missing is not much shorter than the other cases. If
  # this test fails it is likely that no counter measure was taken at all,
  # indicating a severe vulnerability.
  test "executing time when user is missing is not much smaller than other cases" do
    margin = 0.3
    correct_password = "correct_password_1234"
    wrong_password = "wrong_password_1234"

    user = %User{hashed_password: Bcrypt.hash_pwd_salt(correct_password)}

    correct_pw_time = exec_time(fn -> User.valid_password?(user, correct_password) end)
    wrong_pw_time = exec_time(fn -> User.valid_password?(user, wrong_password) end)
    missing_user_time = exec_time(fn -> User.valid_password?(nil, correct_password) end)

    assert missing_user_time > correct_pw_time * margin
    assert missing_user_time > wrong_pw_time * margin
  end
end
