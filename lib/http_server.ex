defmodule HTTPSERVER do
  require Logger
  use Application

  def start(_type, {opts, [file | _]}) do
    import Supervisor.Spec, warn: false

    Logger.info("starting server...")
    Logger.info("server started")

  end
end
