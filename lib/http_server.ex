defmodule HTTPSERVER do
  require Logger
  use Application

  def start(_type, {opts, [file|_]}) do
    import Supervisor.Spec, warn: false

    #get the prot and the file from shell command
    port = Keyword.get(opts, :port) || Application.get_env(:http_server, :port)
    application = HTTPSERVER.CodeLoader.load(file)

    #configure erlang processesapplication
    children = [
      {Task.Supervisor, name: HTTPSERVER.Server.Supervisor},
      {HTTPSERVER.Listener, port: port, application: application}
    ]

    opts = [strategy: :one_for_one, name: HTTPSERVER.Supervisor]

    #start processes
    Supervisor.start_link(children, opts)
  end
end
