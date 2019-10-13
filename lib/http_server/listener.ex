defmodule HTTPSERVER.Listener do
  require Logger

  alias HTTPSERVER.Server

  @options [:binary, packet: :line, active: false, reuseaddr: true]

  # define the mechanics of child processes start and shutdown
  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  def start_link(opts) do
    # Module that contains endpoints and request treatments
    application = Keyword.fetch!(opts, :application)
    # port to allocate server socket
    port = Keyword.fetch!(opts, :port)

    # creating server socket
    {:ok, server_socket} = :gen_tcp.listen(port, @options)

    Logger.info("Listening on port #{port}")

    # creating a new process to listen on the socket
    process = spawn(fn -> loop(server_socket, application) end)

    {:ok, process}
  end

  # loop for accepting and replying to new connections
  defp loop(server_socket, application) do
    #put the data from the socket to a variable
    {:ok, socket} = :gen_tcp.accept(server_socket)

    #Create a new process bellow this Supervisor
    Task.Supervisor.start_child(Server.Supervisor, Server, :serve, [socket, application])

    #Call the loop to keep listening sockets
    loop(server_socket, application)
  end
end
