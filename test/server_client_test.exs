defmodule ServerClientTest do
  alias Server.Client
  alias Client.Stream

  use ExUnit.Case
  doctest Client

  test "default client" do
    client = %Client{}
    assert client.user_id == nil
    assert client.channel_id == nil
    assert client.streams == []
  end

  test "set client" do
    client = Client.set_id(%Client{}, 2)
    assert client.user_id == 2
    assert client.channel_id == nil
    assert client.streams == []
  end

  test "add audio" do
    client = Client.add_stream(%Client{}, 2)
    assert length(client.streams) == 1
    assert List.first(client.streams || %Stream{}).ssrc == 2
    assert Enum.at(client.streams, 0).ssrc == 2
  end

  test "add two audio streams" do
    client =
      %Client{}
      |> Client.add_stream(2)
      |> Client.add_stream(3)

    assert length(client.streams) == 2
    assert Enum.at(client.streams, 0).ssrc == 2
    assert Enum.at(client.streams, 1).ssrc == 3
  end

  test "client with two audio streams" do
    client = %Client{user_id: 1, channel_id: 1, streams: [%Stream{ssrc: 2}, %Stream{ssrc: 3}]}

    assert client.user_id == 1
    assert client.channel_id == 1
    assert length(client.streams) == 2
    assert Enum.at(client.streams, 0).ssrc == 2
    assert Enum.at(client.streams, 1).ssrc == 3
  end
end
