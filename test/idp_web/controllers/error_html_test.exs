defmodule IdpWeb.ErrorHTMLTest do
  use IdpWeb.ConnCase, async: true
  alias IdpWeb.ErrorHTML

  # Bring render_to_string/4 for testing custom views
  import Phoenix.Template

  test "renders 404.html" do
    assert render_to_string(ErrorHTML, "404", "html", []) =~
             "Sorry, the page you are looking for does not exist."
  end

  test "renders 500.html" do
    assert render_to_string(ErrorHTML, "500", "html", []) =~
             "Oops, an internal server error occurred."
  end

  test "renders 400.html" do
    assert render_to_string(ErrorHTML, "400", "html", []) =~
             "Oops, the request was malformed."
  end

  describe "invalid_registration.html" do
    test "" do
      assert render_to_string(
               ErrorHTML,
               "invalid_registration",
               "html",
               redirect_uri: "https://page.com/callback"
             ) =~
               "Invalid SSO client registration"
    end

    test "contains link to client's redirect_uri" do
      assert render_to_string(
               ErrorHTML,
               "invalid_registration",
               "html",
               redirect_uri: "https://page.com/callback"
             )
    end
  end

  describe "missing_authorize_params.html" do
    test "renders the error page" do
      assert render_to_string(
               ErrorHTML,
               "missing_authorize_params",
               "html",
               redirect_uri: "https://page.com/callback"
             ) =~
               "Missing required parameters"
    end

    test "contains link to client's redirect_uri" do
      assert render_to_string(
               ErrorHTML,
               "missing_authorize_params",
               "html",
               redirect_uri: "https://page.com/callback"
             ) =~ ~s|href="https://page.com/callback"|
    end
  end
end
