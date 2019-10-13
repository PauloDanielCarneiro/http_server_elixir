defmodule HTTPSERVER.CLI do
  def main(args \\ []) do
    args
    |> convert_and_start

    Process.sleep(:infinity)
  end

  def convert_and_start(args) do
    #parse the shell command to a list with a pattern match
    {opts, files, _} = OptionParser.parse(args, switches: [port: :integer], aliases: [port: :p])
    #start application
    HTTPSERVER.start(:transient, {opts, files})
  end
end
