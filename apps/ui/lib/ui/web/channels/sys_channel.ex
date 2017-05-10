defmodule TuxSentry.UI.Web.SysChannel do
  use TuxSentry.UI.Web, :channel
  @moduledoc """
  """

  def join("room:sys", _payload, socket) do
    {:ok, socket}
  end

  def leave(_reason, socket) do
    {:ok, socket}
  end

end
