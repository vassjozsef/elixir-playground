defmodule Media do
  defstruct audio: 0,
            video: 0

  def new() do
    %__MODULE__{
      audio: 0,
      video: 0
    }
  end

  def new(audio) do
    %__MODULE__{
      audio: audio
    }
  end

  def new(audio, video) do
    %__MODULE__{
      audio: audio,
      video: video
    }
  end
end
