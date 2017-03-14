defmodule TuxSentry.UI.Web.PageController do
  use TuxSentry.UI.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
