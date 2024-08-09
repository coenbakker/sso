defmodule Mix.Tasks.FormatAll do
  use Mix.Task

  @shortdoc "Run tests for the authorization server and the example client application"
  def run(args) do
    args_string = Enum.join(args, " ")
    Mix.shell().cmd("mix format #{args_string}")
    Mix.shell().cmd("mix format #{args_string}", cd: "example_client")
  end
end
