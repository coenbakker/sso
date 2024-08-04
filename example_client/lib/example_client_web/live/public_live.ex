defmodule ExampleClientWeb.PublicLive do
  use ExampleClientWeb, :live_view

  def render(assigns) do
    ~H"""
    <div>
      <h1>Public Page</h1>
      <p>You do not have to be authenticated to see this page.</p>
    </div>
    """
  end
end
