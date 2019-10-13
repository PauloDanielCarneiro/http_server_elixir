defmodule HTTPSERVER.Server do
  require Logger

  # list of HTTP responses
  @messages %{
    100 => "Continue",
    200 => "OK",
    201 => "Created",
    202 => "Accepted",
    204 => "No Content",
    400 => "Bad Request",
    401 => "Unauthorized",
    403 => "Forbidden",
    404 => "Not Found",
    418 => "I'm a teapot",
    420 => "Enhance Your Calm",
    500 => "Internal Server Error",
    502 => "Request Timeout",
    503 => "Service Temporarily Unavailable"
  }

  # controls the request lifecycle
  def serve(client, application) do
    client
    |> read_from_socket
    |> parse
    |> treat_request(application)
    |> send_response(client)
  end

  # read incoming information from socket
  defp read_from_socket(socket) do
    {:ok, req_line} = :gen_tcp.recv(socket, 0)
    headers = get_headers(socket)

    {req_line, headers}
  end

  # splits headers and request-line in a way the handlers understand
  defp parse({req_line, headers}) do
    [verb, path, _version] = String.split(req_line)

    {path, query} = parse_uri(path)

    Logger.info("Recieved #{verb} #{path}#{query}")
    Logger.info("Called with headers:")
    IO.inspect(headers)

    %{
      method: verb,
      path: path,
      query: query,
      headers: headers
    }
  end

  # recieve headers from socket-stream
  defp get_headers(socket, headers \\ []) do
    {:ok, line} = :gen_tcp.recv(socket, 0)

    case Regex.run(~r/(\w+): (.*)/, line) do
      [_line, key, value] -> [{key, value}] ++ get_headers(socket, headers)
      _ -> []
    end
  end

  # splits URI into endpoint and querystring
  defp parse_uri(path) do
    case String.split(path, "?") do
      [path] -> {path, []}
      [path, query] -> {path, query}
    end
  end

  # calls handler with parsed request info
  defp treat_request(request, application) do
    application.call(request)
  end

  # sends to socket an HTTP response based on return from the handler
  defp send_response(data, socket) do
    code = data[:code] || 500
    body = data[:body] || ""
    headers = format_headers(data[:headers])

    information = """
    HTTP/1.1 #{code} #{message(code)}
    Date: #{:httpd_util.rfc1123_date()}
    Content-Type: #{data[:type] || "text/plain"}
    Content-Length: #{String.length(body)}
    """

    reply = information <> headers <> "\r\n" <> body <> "\r\n"

    :gen_tcp.send(socket, reply)
  end

  # functions for formatting headers according to RFC 7230
  defp format_headers(nil) do
    ""
  end

  defp format_headers(headers) do
    Enum.map_join(headers, "\n", &format_header/1) <> "\n"
  end

  defp format_header({key, value}) do
    "#{key}: #{value}"
  end

  # returns the text message for the corresponding 3-digit code
  defp message(code) do
    @messages[code] || "Unknown"
  end
end
