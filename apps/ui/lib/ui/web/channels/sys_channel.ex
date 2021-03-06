defmodule TuxSentry.UI.Web.SysChannel do
  use TuxSentry.UI.Web, :channel
  @moduledoc """
  """

  def join("room:sys", _payload, socket) do
    {:ok, socket}
  end

  def handle_in("get:facts", msg, socket) do
    broadcast!(socket, "get_facts", msg)
    {:noreply, socket}
  end

  def leave(_reason, socket) do
    {:ok, socket}
  end

end
