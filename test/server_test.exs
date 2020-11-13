defmodule ServerTest do
  alias Server.Client
  alias Client.Stream

  use ExUnit.Case
  doctest Client

  test "server with client" do
    server = Server.add_client(%Server{}, 1, 1)
    assert length(Map.keys(server.clients)) == 1
  end

  test "add client same id" do
    server =
      %Server{}
      |> Server.add_client(1, 1)
      |> Server.add_client(1, 2)

    assert length(Map.keys(server.clients)) == 1
    assert server.clients[1].channel_id == 1
  end

  test "add client stream" do
    server = Server.add_client(%Server{}, 1, 1)
    {res, server} = Server.add_client_stream(server, 1, 1)
    assert res == :ok
    assert length(server.clients[1].streams) == 1
    assert Enum.at(server.clients[1].streams, 0).ssrc == 1
  end

  test "add client stream bad client" do
    server = Server.add_client(%Server{}, 1, 1)
    {res, server} = Server.add_client_stream(server, 2, 1)
    assert res == :error
    assert length(server.clients[1].streams) == 0
  end

  test "add client" do
    client = %Client{user_id: 1, channel_id: 1, streams: [%Stream{ssrc: 1}, %Stream{ssrc: 2}]}
    server = Server.add_client(%Server{}, client)

    assert length(Map.keys(server.clients)) == 1
    assert length(Map.keys(server.ssrcs)) == 2
    assert server.clients[1].channel_id == 1
    assert length(server.clients[1].streams) == 2
    assert Enum.at(server.clients[1].streams, 0).ssrc == 1
    assert Enum.at(server.clients[1].streams, 1).ssrc == 2
    assert server.ssrcs[1] == 1
    assert server.ssrcs[2] == 1
  end

  test "add two clients" do
    client1 = %Client{user_id: 1, channel_id: 1, streams: [%Stream{ssrc: 1}, %Stream{ssrc: 2}]}
    client2 = %Client{user_id: 2, channel_id: 1, streams: [%Stream{ssrc: 3}, %Stream{ssrc: 4}]}

    server =
      %Server{}
      |> Server.add_client(client1)
      |> Server.add_client(client2)

    assert length(Map.keys(server.clients)) == 2
    assert length(Map.keys(server.ssrcs)) == 4
    assert server.clients[1].channel_id == 1
    assert length(server.clients[1].streams) == 2
    assert Enum.at(server.clients[1].streams, 0).ssrc == 1
    assert Enum.at(server.clients[1].streams, 1).ssrc == 2
    assert server.ssrcs[1] == 1
    assert server.ssrcs[2] == 1

    assert server.clients[2].channel_id == 1
    assert length(server.clients[2].streams) == 2
    assert Enum.at(server.clients[2].streams, 0).ssrc == 3
    assert Enum.at(server.clients[2].streams, 1).ssrc == 4
    assert server.ssrcs[3] == 2
    assert server.ssrcs[4] == 2
  end

  test "remove client" do
    client1 = %Client{user_id: 1, channel_id: 1, streams: [%Stream{ssrc: 1}, %Stream{ssrc: 2}]}
    client2 = %Client{user_id: 2, channel_id: 1, streams: [%Stream{ssrc: 3}, %Stream{ssrc: 4}]}

    server =
      %Server{}
      |> Server.add_client(client1)
      |> Server.add_client(client2)

    assert length(Map.keys(server.clients)) == 2
    assert length(Map.keys(server.ssrcs)) == 4

    server = Server.remove_client(server, 1)

    assert length(Map.keys(server.clients)) == 1
    assert length(Map.keys(server.ssrcs)) == 2
  end
end
