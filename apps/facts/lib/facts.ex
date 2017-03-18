defmodule Facts do
  @moduledoc """
  `Facts` module is used to query the underlying system for given details.
  """

  alias Facts.{ External, System }

  @doc """
  `get_facts/0` is the intended to be the primary entry point to the `Facts` module.
  """
  def get_facts do
    case System.get_system_facts do
      {:ok, s} -> IO.puts s
      {:error, _} -> raise "Error"
    end
    case External.get_external_facts do
      {:ok, e} -> IO.puts e
      {:error, _} -> raise "Error"
    end
  end
end
