defmodule ServerTest do
  alias Server.Client

  use ExUnit.Case
  doctest Client

  test "server with client" do
    server = %Server{}
    server2 = Server.add_client(server, 1, 1)
    assert length(Map.keys(server2.clients)) == 1
  end

  test "add client same id" do
    server = %Server{}
    server2 = Server.add_client(server, 1, 1)
    server3 = Server.add_client(server2, 1, 2)
    assert length(Map.keys(server3.clients)) == 1
    assert server3.clients[1].channel_id == 1
  end
end
