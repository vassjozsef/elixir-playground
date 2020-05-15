defmodule Client.Stream do
  @type type :: :audio | :video | :rtx

  @type t :: %__MODULE__{
          type: type,
          ssrc: integer()
        }

  defstruct type: nil,
            ssrc: 0

  def new(type, ssrc) do
    %__MODULE__{
      type: type,
      ssrc: ssrc
    }
  end
end
