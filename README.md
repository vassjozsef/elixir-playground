Elixir Playground
=================

Build:

    mix compile
    mix test
    iex -S mix

Sample usage:

    > recompile
    > client = %Server.Client{}
    > client = Server.Client.set_id(client, 2)
    > client = Server.Client.add_stream(client, 1)
    > Server.Client.log(client)

