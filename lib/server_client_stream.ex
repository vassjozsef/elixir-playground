defmodule Server.Client.Stream do
  @type t :: %__MODULE__{
          ssrc: integer()
        }

  defstruct ssrc: 0

  def new(ssrc) do
    %__MODULE__{
      ssrc: ssrc
    }
  end
end
