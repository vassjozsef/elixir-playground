defmodule ClientTest do
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
    client2 = Client.set_id(client, 2)
    assert client2.user_id == 2
    assert client.channel_id == nil
    assert client.streams == []
  end

  test "add audio" do
    client = %Client{}
    client2 = Client.add_stream(client, :audio, 2)
    assert length(client2.streams) == 1
    assert List.first(client2.streams).type == :audio
    assert List.first(client2.streams).ssrc == 2

    assert Enum.find(client2.streams, %Stream{}, fn stream -> stream.type == :audio end).ssrc == 2
    assert Enum.find(client2.streams, %Stream{}, fn stream -> stream.type == :video end).ssrc == 0
    assert Enum.find(client2.streams, %Stream{}, fn stream -> stream.type == :rtx end).ssrc == 0
  end

  test "add audio and video" do
    client = %Client{}
    client2 = Client.add_stream(client, :audio, 2)
    client3 = Client.add_stream(client2, :video, 3)
    assert length(client3.streams) == 2
    assert List.first(client3.streams).type == :audio
    assert List.first(client3.streams).ssrc == 2
    assert List.last(client3.streams).type == :video
    assert List.last(client3.streams).ssrc == 3

    assert Enum.find(client3.streams, %Stream{}, fn stream -> stream.type == :audio end).ssrc == 2
    assert Enum.find(client3.streams, %Stream{}, fn stream -> stream.type == :video end).ssrc == 3
    assert Enum.find(client3.streams, %Stream{}, fn stream -> stream.type == :rtx end).ssrc == 0
  end
end
