defmodule Mix.Tasks.TestAll do
  use Mix.Task

  @shortdoc "Run tests for the authorization server and the example client application"
  def run(_args) do
    Mix.shell().cmd("mix test")
    Mix.shell().cmd("cd example_client && mix test")
  end
end
