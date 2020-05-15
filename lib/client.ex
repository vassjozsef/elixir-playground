defmodule Client do
  alias Client.Stream

  defstruct user_id: nil,
            channel_id: nil,
            streams: []

  def log(%__MODULE__{user_id: user_id, channel_id: channel_id, streams: streams}) do
    IO.inspect(channel_id, label: "Channel id")
    IO.inspect(user_id, label: "User id")
    IO.inspect(streams, label: "Streams")
  end

  def set_id(user, id) do
    %__MODULE__{
      user
      | user_id: id
    }
  end

  def add_stream(user, type, ssrc) do
    %__MODULE__{
      user
      | streams: user.streams ++ [Stream.new(type, ssrc)]
    }
  end
end
