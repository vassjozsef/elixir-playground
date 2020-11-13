defmodule Server do
  alias Server.Client

  defstruct clients: Map.new(),
            ssrcs: Map.new()

  def add_client(
        %__MODULE__{ssrcs: ssrcs} = server,
        %Client{user_id: user_id, streams: streams} = client
      ) do
    case client_find(server.clients, user_id) do
      {:ok, _} ->
        server

      :error ->
        ssrcs = for stream <- streams, into: ssrcs, do: {stream.ssrc, user_id}

        %__MODULE__{
          server
          | clients: Map.put(server.clients, user_id, client),
            ssrcs: ssrcs
        }
    end
  end

  def add_client(server, user_id, channel_id) do
    case client_find(server.clients, user_id) do
      {:ok, _} ->
        server

      :error ->
        client = %Client{user_id: user_id, channel_id: channel_id}

        %__MODULE__{
          server
          | clients: Map.put(server.clients, user_id, client)
        }
    end
  end

  def add_client_stream(server, user_id, ssrc) do
    case client_find(server.clients, user_id) do
      {:ok, client} ->
        client = Client.add_stream(client, ssrc)

        {:ok,
         %__MODULE__{
           clients: Map.replace!(server.clients, client.user_id, client)
         }}

      :error ->
        {:error, server}
    end
  end

  defp client_find(clients, user_id) do
    Map.fetch(clients, user_id)
  end
end
