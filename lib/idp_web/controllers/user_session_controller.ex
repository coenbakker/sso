defmodule IdpWeb.UserSessionController do
  use IdpWeb, :controller

  alias Idp.Accounts
  alias IdpWeb.UserAuth

  @oauth_login_path "/auth/v1/log_in"

  def create(conn, %{"_action" => "oauth_login"} = params) do
    create(conn, params, "Authorization successful!", is_oauth_login: true)
  end

  def create(conn, %{"_action" => "registered"} = params) do
    create(conn, params, "Account created successfully!")
  end

  def create(conn, %{"_action" => "password_updated"} = params) do
    conn
    |> put_session(:user_return_to, ~p"/users/settings")
    |> create(params, "Password updated successfully!")
  end

  def create(conn, params) do
    create(conn, params, "Welcome back!")
  end

  defp create(conn, %{"user" => user_params}, info, opts \\ []) do
    %{"email" => email, "password" => password} = user_params

    if user = Accounts.get_user_by_email_and_password(email, password) do
      conn
      |> put_flash(:info, info)
      |> UserAuth.log_in_user(user, user_params, opts)
    else
      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      conn =
        conn
        |> put_flash(:error, "Invalid email or password")
        |> put_flash(:email, String.slice(email, 0, 160))

      case Keyword.get(opts, :is_oauth_login, false) do
        true -> redirect(conn, to: @oauth_login_path)
        false -> redirect(conn, to: ~p"/users/log_in")
      end
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end
end
