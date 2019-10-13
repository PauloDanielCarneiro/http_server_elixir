defmodule HTTPSERVER.CLI do
  def main(args \\ []) do
    args
    |> convert_and_start

  end

  defp start_application() do
    {opts, files, _} = OptionParser.parse(args, switches: [port: :integer], aliases: [port: :p])
    HTTPSERVER.start(:transient, {opts, files})
  end
end
