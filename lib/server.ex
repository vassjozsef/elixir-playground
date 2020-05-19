defmodule Server do
  alias Server.Client
  defstruct clients: Map.new()

  def add_client(server, user_id, channel_id) do
    case client_find(server.clients, user_id) do
      {:ok, client} ->
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
  end

  defp client_find(clients, user_id) do
    Map.fetch(clients, user_id)
  end
end
