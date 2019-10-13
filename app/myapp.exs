defmodule MyApp do
  # handle the / path
  def call(%{method: "GET", path: "/"}),
    do: %{code: 200, type: "text/plain", body: "Returns a List of resources"}

  def call(%{method: "POST", path: "/create"}),
    do: %{
      code: 201,
      type: "application/json",
      body:
        "{\"message\":\"This method creates a new resource and returns 201\",\"status\":\"created\"}"
    }

  def call(%{method: "GET", path: "/amiauthorized"}),
    do: %{
      code: 401,
      type: "application/json",
      body: "{\"message\":\"You\"re not authorized\",\"status\":\"unauthoried\"}"
    }

  def call(%{method: "GET", path: "/teapot"}),
    do: %{
      code: 418,
      type: "application/json",
      body: "{\"message\":\"Use me\",\"status\":\"i'm a teapot\"}"
    }

  def call(%{method: "DELETE", path: "/"}),
    do: %{code: 204, type: "text/plain", body: ""}

  def call(%{method: "OPTIONS", path: "/"}),
    do: %{code: 200, type: "text/plain", body: "HEAD, GET, POST, DELETE, OPTIONS"}

  def call(%{method: "HEAD", path: "/"}),
    do: %{code: 200, type: "text/plain", body: ""}

  def call(%{method: "POST", path: "/blazeit"}),
    do: %{
      code: 420,
      type: "text/plain",
      body: "Chill, bro \n Listen to this: https://www.youtube.com/watch?v=mACqcZZwG0k"
    }

  # everything else is a 404 response
  def call(_),
    do: %{
      code: 404,
      type: "text/plain",
      body: "This is not the response you're looking for, move along"
    }
end
