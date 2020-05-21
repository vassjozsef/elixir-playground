defmodule ServerTest do
  alias Server.Client

  use ExUnit.Case
  doctest Client

  test "server with client" do
    server = %Server{}
    server = Server.add_client(server, 1, 1)
    assert length(Map.keys(server.clients)) == 1
  end

  test "add client same id" do
    server = %Server{}
    server = Server.add_client(server, 1, 1)
    server = Server.add_client(server, 1, 2)
    assert length(Map.keys(server.clients)) == 1
    assert server.clients[1].channel_id == 1
  end

  test "add client stream" do
    server = %Server{}
    server = Server.add_client(server, 1, 1)
    {res, server} = Server.add_client_stream(server, 1, 1)
    assert res == :ok
    assert length(server.clients[1].streams) == 1
    assert Enum.at(server.clients[1].streams, 0).ssrc == 1
  end

  test "add client stream bad client" do
    server = %Server{}
    server = Server.add_client(server, 1, 1)
    {res, server} = Server.add_client_stream(server, 2, 1)
    assert res == :error
    assert length(server.clients[1].streams) == 0
  end
end
