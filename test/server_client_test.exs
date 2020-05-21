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
    client = %Client{}
    client = Client.set_id(client, 2)
    assert client.user_id == 2
    assert client.channel_id == nil
    assert client.streams == []
  end

  test "add audio" do
    client = %Client{}
    client = Client.add_stream(client, 2)
    assert length(client.streams) == 1
    assert List.first(client.streams || %Stream{}).ssrc == 2
    assert Enum.at(client.streams, 0).ssrc == 2
  end

  test "add two audio streams" do
    client = %Client{}
    client = Client.add_stream(client, 2)
    client = Client.add_stream(client, 3)

    assert length(client.streams) == 2
    assert Enum.at(client.streams, 0).ssrc == 2
    assert Enum.at(client.streams, 1).ssrc == 3
  end
end
