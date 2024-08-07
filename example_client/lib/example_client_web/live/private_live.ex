defmodule ExampleClientWeb.PrivateLive do
  use ExampleClientWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1 class="text-4xl font-semibold">The Private Page</h1>
    <p class="text-lg mt-2 mb-8">This is a private page. You need to log in to see it.</p>
    """
  end
end
