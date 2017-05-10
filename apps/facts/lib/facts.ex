defmodule Facts do
  @moduledoc """
  `Facts` module is used to query the underlying system for given details.
  """

  alias Facts.{ External, System }
  # use GenServer
  @name :tux_sentry_facts
  @doc """
  `get_facts/0` is the intended to be the primary entry point to the `Facts` module.
  """

  # def start_link(opts) do
  #   GenServer.start_link(__MODULE__, %{}, [name: @name] ++ opts)
  # end
  #
  # def get_facts do
  #   GenServer.call(__MODULE__, :get_facts)
  # end
  #
  # def handle_call(:get_facts, _from, state) do
  #   {:reply, %{}, state}
  # end

end
