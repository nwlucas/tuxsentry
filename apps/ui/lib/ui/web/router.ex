defmodule TuxSentry.UI.Web.Router do
  use TuxSentry.UI.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/sys", TuxSentry.UI.Web do
    pipe_through :api
  end

  scope "/", TuxSentry.UI.Web do
    pipe_through :browser # Use the default browser stack

    get "/*path", PageController, :index
  end
end
