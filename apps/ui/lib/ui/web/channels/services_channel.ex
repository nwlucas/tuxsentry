defmodule TuxSentry.UI.Web.ServicesChannel do
  use TuxSentry.UI.Web, :channel
  @moduledoc """
  """

  def join("room:services", _payload, socket) do
    {:ok, socket}
  end

  def leave(_reason, socket) do
    {:ok, socket}
  end
end
