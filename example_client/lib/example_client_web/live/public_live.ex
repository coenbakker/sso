defmodule ExampleClientWeb.PublicLive do
  use ExampleClientWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1 class="text-4xl font-semibold">The Public Page</h1>
    <p class="text-lg mt-2 mb-8">This is a public page. You can see it without logging in.</p>
    <.link navigate={~p"/private"} class="text-blue-800 underline">Go to the private page</.link>
    """
  end
end
