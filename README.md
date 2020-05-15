Elixir Playground
=================

Build:

    mix compile
    mix test
    iex -S mix

Sample usage:

    > recompile
    > c = %Client{}
    > c2 = Client.set_id(c, 2)
    > c3 = Client.add_stream(c2, :audio, 1)
    > c4 = Client.add_stream(c3, :video, 2)
    > Client.log(c4)

