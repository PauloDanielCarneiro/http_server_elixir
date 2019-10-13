# HTTPSERVER

A tiny concurrent and fault-tolerant HTTP server.

## Usage

Docker:
Run `docker-compose up` and send request to localhost:8000 with the path defined in app/myapp.exs.

Everytime you make a change in any file, please run `docker-compose down`and `docker-compose up`.

If you want to make use of this application without docker, please install elixir with erlang v22. After you can create an app file:

```elixir
# in myapp.exs
defmodule MyApp do
  # handle the / path
  def call(%{method: "HEAD", path: "/"}),
    do: %{code: 200, type: "text/plain", body: ""}

  # everything else is a 404 response
  def call(_),
    do: %{code: 404, body: "say what now?"}
end
```

Build the script:

```shell
mix deps.get
mix escript.build
```


Then, start the server

```shell
./http_server examples/myapp.exs --port 3000
```

And send request to the given port.

License: MIT
