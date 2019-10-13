defmodule MyApp do
  # handle the / path
  def call(%{method: "GET", path: "/"}),
    do: %{code: 200, type: "text/plain", body: "GET"}

  def call(%{method: "POST", path: "/"}),
    do: %{code: 200, type: "text/plain", body: "POST"}

  def call(%{method: "DELETE", path: "/"}),
    do: %{code: 200, type: "text/plain", body: "DELETE"}

  def call(%{method: "OPTIONS", path: "/"}),
    do: %{code: 200, type: "text/plain", body: "HEAD, GET, POST, DELETE, OPTIONS"}

  def call(%{method: "HEAD", path: "/"}),
    do: %{code: 200, type: "text/plain", body: ""}

  # everything else is a 404 response
  def call(_),
    do: %{code: 404, body: "say what now?"}
end
