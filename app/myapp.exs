defmodule MyApp do
  # GET on /
  def call(%{method: "GET", path: "/"}),
    do: %{code: 200, type: "text/plain", body: "Returns a List of resources"}

  # example of POST with /create
  def call(%{method: "POST", path: "/create"}),
    do: %{
      code: 201,
      type: "application/json",
      body:
        "{\"message\":\"This method creates a new resource and returns 201\",\"status\":\"created\"}"
    }

  # returns 401
  def call(%{method: "GET", path: "/amiauthorized"}),
    do: %{
      code: 401,
      type: "application/json",
      body: "{\"message\":\"You\"re not authorized\",\"status\":\"unauthoried\"}"
    }

  # endpoint for 418
  def call(%{method: "GET", path: "/teapot"}),
    do: %{
      code: 418,
      type: "application/json",
      body: "{\"message\":\"Use me\",\"status\":\"i'm a teapot\"}"
    }

  # example of DELETE on /erase
  def call(%{method: "DELETE", path: "/erase"}),
    do: %{code: 204, type: "text/plain", body: ""}

  # OPTIONS on /
  def call(%{method: "OPTIONS", path: "/"}),
    do: %{code: 200, type: "text/plain", body: "HEAD, GET, OPTIONS"}

  # HEAD on /
  def call(%{method: "HEAD", path: "/"}),
    do: %{code: 200, type: "text/plain", body: ""}

  # showcase of error 420
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
