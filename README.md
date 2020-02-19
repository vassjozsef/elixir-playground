Elixir Playground
=================

Build:

    mix compile
    mix test
    iex -S mix

Sample usage:

   recompile
   user = %User{}
   user2 = User.set_user(user, 2)
   User.log(user)
   user3 = User.set_audio(user2, 3)
   User.set_video(user3, 4)

