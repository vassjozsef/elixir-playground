defmodule UserTest do
  use ExUnit.Case
  doctest User

  test "default user" do
    user = %User{}
    assert user.user_id == 1
  end

  test "set user" do
    user = %User{}
    user2 = User.set_user(user, 2)
    assert user2.user_id == 2
  end

  test "set audio" do
    user = %User{}
    user2 = User.set_audio(user, 2)
    assert user2.media.audio == 2
    assert user2.media.video == 0
  end

  test "set audio and video" do
    user = %User{}
    user2 = User.set_audio(user, 2)
    user3 = User.set_video(user2, 3)
    assert user3.media.audio == 2
    assert user3.media.video == 3
  end
end
