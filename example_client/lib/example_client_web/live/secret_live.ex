defmodule ExampleClientWeb.SecretLive do
  use ExampleClientWeb, :live_view

  def render(assigns) do
    ~H"""
    <div>
      <h1>Secret Page</h1>
      <p>You have to be authenticated to see this page.</p>
    </div>
    """
  end
end
