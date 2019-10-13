defmodule HTTPSERVER do
  require Logger
  use Application

  def start(_type, {opts, [file|_]}) do
    import Supervisor.Spec, warn: false

    port = Keyword.get(opts, :port) || Application.get_env(:http_server, :port)
    app = HTTPSERVER.CodeLoader.load(file)

    children = [
      {Task.Supervisor, name: HTTPSERVER.Server.Supervisor},
      {HTTPSERVER.Listener, port: port, app: app}
    ]

    opts = [strategy: :one_for_all, name: HTTPSERVER.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
