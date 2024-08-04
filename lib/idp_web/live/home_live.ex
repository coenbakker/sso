defmodule IdpWeb.HomeLive do
  use IdpWeb, :live_view

  def render(assigns) do
    ~H"""
    <div>
      <h1>Welcome to IdpWeb!</h1>
      <p>This is the home page.</p>
    </div>
    """
  end
end
