defmodule Mix.Tasks.TestAll do
  use Mix.Task

  @shortdoc "Run tests for the authorization server and the example client application"
  def run(_args) do
    Mix.shell().cmd("mix test")
    Mix.shell().cmd("mix test", cd: "example_client")
  end
end
