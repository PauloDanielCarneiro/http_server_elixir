defmodule HTTPSERVER.CodeLoader do
  #read router file
  def load(path_to_file) do
    path_to_file
    |> Code.require_file(".")
    |> extract_module
  end

  defp extract_module([{module, _}]), do: module
end
