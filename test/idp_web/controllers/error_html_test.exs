defmodule IdpWeb.ErrorHTMLTest do
  use IdpWeb.ConnCase, async: true

  # Bring render_to_string/4 for testing custom views
  import Phoenix.Template

  test "renders 404.html" do
    assert render_to_string(IdpWeb.ErrorHTML, "404", "html", []) =~ "Sorry, the page you are looking for does not exist."
  end

  test "renders 500.html" do
    assert render_to_string(IdpWeb.ErrorHTML, "500", "html", []) =~ "Oops, an internal server error occurred."
  end

  test "renders 400.html" do
    assert render_to_string(IdpWeb.ErrorHTML, "400", "html", []) =~ "Oops, the request was malformed."
  end
end
