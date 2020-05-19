Elixir Playground
=================

Build:

    mix compile
    mix test
    iex -S mix

Sample usage:

    > recompile
    > c = %Server.Client{}
    > c2 = Server.Client.set_id(c, 2)
    > c3 = Server.Client.add_stream(c2, 1)
    > Server.Client.log(c3)

