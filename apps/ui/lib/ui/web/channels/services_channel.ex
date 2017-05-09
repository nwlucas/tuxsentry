defmodule TuxSentry.UI.Web.ServicesChannel do
  use TuxSentry.UI.Web, :channel
  alias TuxSentry.UI.Web.Endpoint
  @moduledoc """
  """

  def join("services") do

  end

  def leave(_reason, socket) do
    {:ok, socket}
  end

  def notify(event) do
  end
end
