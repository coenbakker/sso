defmodule ExampleClientWeb.PublicLive do
  use ExampleClientWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="m-20">
      <h1>Public Page</h1>
      <p class="mb-10">You do not have to be authenticated to see this page.</p>
      <.link href={~p"/secret"} class="bg-neutral-800 text-white p-3">View secret page</.link>
    </div>
    """
  end
end
