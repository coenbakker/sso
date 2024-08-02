defmodule Idp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      IdpWeb.Telemetry,
      # Start the Ecto repository
      Idp.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Idp.PubSub},
      # Start Finch
      {Finch, name: Idp.Finch},
      # Start the Endpoint (http/https)
      IdpWeb.Endpoint
      # Start a worker by calling: Idp.Worker.start_link(arg)
      # {Idp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Idp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    IdpWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
