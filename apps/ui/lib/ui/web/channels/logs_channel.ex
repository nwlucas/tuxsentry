defmodule TuxSentry.UI.Web.LogsChannel do
  use TuxSentry.UI.Web, :channel
  @moduledoc """
  """

  def join("room:logs", _payload, socket) do
    {:ok, socket}
  end

  def leave(_reason, socket) do
    {:ok, socket}
  end
end
