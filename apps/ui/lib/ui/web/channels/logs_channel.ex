defmodule TuxSentry.UI.Web.LogsChannel do
  use TuxSentry.UI.Web, :channel
  alias TuxSentry.UI.Web.Endpoint
  @moduledoc """
  """

  def join("logs ") do

  end

  def leave(_reason, socket) do
    {:ok, socket}
  end

  def notify(event) do
  end
end
