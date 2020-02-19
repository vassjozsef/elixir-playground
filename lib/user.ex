defmodule User do
  defstruct user_id: 1,
            channel_id: 1,
            media: %Media{}

  def log(%__MODULE__{user_id: user_id, channel_id: channel_id, media: media}) do
    IO.inspect(channel_id, label: "Channel id")
    IO.inspect(user_id, label: "User id")
    IO.inspect(media, label: "Media")

    IO.puts(
      "User id: #{user_id}, channel id: #{channel_id}, audio: #{media.audio}, video: #{
        media.video
      }"
    )
  end

  def set_user(user, user_id) do
    %__MODULE__{
      user
      | user_id: user_id
    }
  end

  def set_audio(user, audio) do
    %__MODULE__{
      user
      | media: %Media{audio: audio}
    }
  end

  def set_video(%__MODULE__{media: media} = user, video) do
    %__MODULE__{
      user
      | media: %Media{audio: media.audio, video: video}
    }
  end
end
